using Dapper;
using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.SqlServer.Models;
using DataFlowKit.DbMigrator.SqlServer.TypesConverter;
using Microsoft.Data.SqlClient;
using System.Data;
using System.Text;

namespace DataFlowKit.DbMigrator.SqlServer
{

    public class StoredProcAnalyzer
    {
        private readonly string _connectionString;

        public StoredProcAnalyzer(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "DBO")
        {
            var spDefinition = GetStoredProcDefinition(storedProcName);
            var parameters = GetStoredProcParameters(storedProcName);
            var resultSets = GetResultSetStructures(storedProcName, parameters);
            string relativePathOfEntityFolder = $"{DefaultValueProvider.GetSPProjectName()}/{DefaultValueProvider.GetSPFolderName()}";
            var classCode = GenerateClassFile(storedProcName, parameters, resultSets, relativePathOfEntityFolder);
            if (string.IsNullOrEmpty(outputPath))
            {
                outputPath = DirectorySearcher.FindOrCreateProjectFolder(DefaultValueProvider.GetSPProjectName(), DefaultValueProvider.GetSPFolderName());
            }
            File.WriteAllText(Path.Combine(outputPath, $"{SanitizeName(storedProcName)}{namingConvention}.cs"), classCode);
        }

        private string SanitizeName(string name)
        {
            return new string(name.Where(c => char.IsLetterOrDigit(c)).ToArray());
        }

        private string GetStoredProcDefinition(string storedProcName)
        {
            using var connection = new SqlConnection(_connectionString);
            return connection.QueryFirstOrDefault<string>(
                "SELECT OBJECT_DEFINITION(OBJECT_ID(@StoredProcName))",
                new { StoredProcName = storedProcName });
        }

        private IEnumerable<ParameterInfo> GetStoredProcParameters(string storedProcName)
        {
            using var connection = new SqlConnection(_connectionString);
            return connection.Query<ParameterInfo>(@"
            SELECT 
                p.name AS ParameterName,
                TYPE_NAME(p.user_type_id) AS ParameterType,
                p.max_length AS MaxLength,
                p.precision AS Precision,
                p.scale AS Scale,
                p.is_output AS IsOutput,
                p.is_nullable AS IsNullable,
                t.is_table_type AS IsTableType,
                t.is_user_defined AS IsUserDefined
            FROM sys.parameters p
            LEFT JOIN sys.table_types tt ON p.user_type_id = tt.user_type_id
            LEFT JOIN sys.types t ON p.user_type_id = t.user_type_id
            WHERE OBJECT_ID = OBJECT_ID(@StoredProcName)
            ORDER BY p.parameter_id",
                new { StoredProcName = storedProcName });
        }

        private List<ResultSetInfo> GetResultSetStructures(string storedProcName, IEnumerable<ParameterInfo> parameters)
        {
            var resultSets = new List<ResultSetInfo>();

            using var connection = new SqlConnection(_connectionString);
            connection.Open();

            using var command = new SqlCommand(storedProcName, connection)
            {
                CommandType = CommandType.StoredProcedure
            };
            foreach (var param in parameters)
            {
                if (param.IsOutput) continue;
                if (param.IsTableType)
                {
                    var tvpSchema = GetTVPSchema(param.ParameterType);
                    var dt = new DataTable();
                    foreach (var col in tvpSchema)
                    {
                        dt.Columns.Add(col.ColumnName, TypesConverterSql.MapSqlTypeToDotNetType(col.DataType));
                    }
                    command.Parameters.Add(new SqlParameter(param.ParameterName, dt));
                }
                else
                {
                    command.Parameters.AddWithValue(param.ParameterName, GetDummyValue(param));
                }
            }
            foreach (var param in parameters.Where(p => p.IsOutput))
            {
                command.Parameters.Add(new SqlParameter
                {
                    ParameterName = param.ParameterName,
                    Direction = ParameterDirection.Output,
                    SqlDbType = GetSqlDbType(param.ParameterType)
                });
            }

            using var reader = command.ExecuteReader(CommandBehavior.SchemaOnly);
            int resultSetIndex = 0;

            do
            {
                var schemaTable = reader.GetSchemaTable();
                if (schemaTable == null) continue;

                var columns = new List<ColumnInfo>();
                foreach (DataRow row in schemaTable.Rows)
                {
                    columns.Add(new ColumnInfo
                    {
                        ColumnName = row["ColumnName"].ToString(),
                        DataType = TypesConverterSql.MapDotNetTypeToSqlType(((Type)row["DataType"]).Name),
                        IsNullable = (bool)row["AllowDBNull"],
                        MaxLength = row["ColumnSize"] as int?,
                        Precision = row["NumericPrecision"] as byte?,
                        Scale = row["NumericScale"] as byte?
                    });
                }

                resultSets.Add(new ResultSetInfo
                {
                    Index = resultSetIndex++,
                    Columns = columns
                });

            } while (reader.NextResult());

            return resultSets;
        }



        private List<ColumnInfo> GetTVPSchema(string tvpTypeName)
        {
            using var connection = new SqlConnection(_connectionString);
            return connection.Query<ColumnInfo>(@"
            SELECT 
                c.name AS ColumnName,
                TYPE_NAME(c.user_type_id) AS DataType,
                c.is_nullable AS IsNullable,
                c.max_length AS MaxLength,
                c.precision AS Precision,
                c.scale AS Scale
            FROM sys.table_types tt
            JOIN sys.columns c ON tt.type_table_object_id = c.object_id
            WHERE tt.name = @TvpTypeName
            ORDER BY c.column_id",
                new { TvpTypeName = tvpTypeName }).ToList();
        }

        private object GetDummyValue(ParameterInfo param)
        {
            if (param.IsNullable) return DBNull.Value;

            return param.ParameterType.ToLower() switch
            {
                "int" => 0,
                "bigint" => 0L,
                "smallint" => (short)0,
                "tinyint" => (byte)0,
                "bit" => false,
                "datetime" => DateTime.MinValue,
                "date" => DateTime.MinValue,
                "time" => TimeSpan.Zero,
                "decimal" => 0m,
                "numeric" => 0m,
                "float" => 0.0,
                "real" => 0.0f,
                "money" => 0m,
                "uniqueidentifier" => Guid.Empty,
                _ => DBNull.Value
            };
        }

        private SqlDbType GetSqlDbType(string sqlType)
        {
            return sqlType.ToLower() switch
            {
                "int" => SqlDbType.Int,
                "bigint" => SqlDbType.BigInt,
                "smallint" => SqlDbType.SmallInt,
                "tinyint" => SqlDbType.TinyInt,
                "bit" => SqlDbType.Bit,
                "datetime" => SqlDbType.DateTime,
                "date" => SqlDbType.Date,
                "time" => SqlDbType.Time,
                "decimal" => SqlDbType.Decimal,
                "numeric" => SqlDbType.Decimal,
                "float" => SqlDbType.Float,
                "real" => SqlDbType.Real,
                "money" => SqlDbType.Money,
                "uniqueidentifier" => SqlDbType.UniqueIdentifier,
                "varchar" => SqlDbType.VarChar,
                "nvarchar" => SqlDbType.NVarChar,
                "char" => SqlDbType.Char,
                "nchar" => SqlDbType.NChar,
                "text" => SqlDbType.Text,
                "ntext" => SqlDbType.NText,
                "binary" => SqlDbType.Binary,
                "varbinary" => SqlDbType.VarBinary,
                "image" => SqlDbType.Image,
                _ => SqlDbType.Variant
            };
        }

        private string GenerateClassFile(string storedProcName,
                                       IEnumerable<ParameterInfo> parameters,
                                       List<ResultSetInfo> resultSets, string relativePathOfEntityFolder)
        {
            string namespaceName = relativePathOfEntityFolder.Replace("/", ".");
            var className = SanitizeName(storedProcName);
            var requestClassName = $"{className}Request";
            var responseClassName = $"{className}Response";

            var sb = new StringBuilder();

            // Add header
            sb.AppendLine("// Auto-generated code");
            sb.AppendLine("// Generated from stored procedure: " + storedProcName);
            sb.AppendLine("using System;");
            sb.AppendLine("using System.Collections.Generic;");
            sb.AppendLine("using System.Data;");
            sb.AppendLine();
            sb.AppendLine($"namespace {relativePathOfEntityFolder}");
            sb.AppendLine("{");

            // Generate request class
            sb.AppendLine($"    public class {requestClassName}");
            sb.AppendLine("    {");

            // Regular parameters
            foreach (var param in parameters.Where(p => !p.IsOutput && !p.IsTableType))
            {
                var type = TypesConverterSql.MapSqlTypeToCSharp(param.ParameterType, param.IsNullable);
                sb.AppendLine($"        public {type} {param.ParameterName} {{ get; set; }}");
            }

            // TVP parameters
            foreach (var param in parameters.Where(p => p.IsTableType))
            {
                var tvpClassName = $"{SanitizeName(param.ParameterName)}TableType";
                sb.AppendLine($"        public IEnumerable<{tvpClassName}> {param.ParameterName} {{ get; set; }}");
            }

            sb.AppendLine("    }");
            sb.AppendLine();

            // Generate TVP classes
            foreach (var param in parameters.Where(p => p.IsTableType))
            {
                var tvpSchema = GetTVPSchema(param.ParameterType);
                var tvpClassName = $"{SanitizeName(param.ParameterName)}TableType";

                sb.AppendLine($"    public class {tvpClassName}");
                sb.AppendLine("    {");
                foreach (var col in tvpSchema)
                {
                    var type = TypesConverterSql.MapSqlTypeToCSharp(col.DataType, col.IsNullable);
                    sb.AppendLine($"        public {type} {col.ColumnName} {{ get; set; }}");
                }
                sb.AppendLine("    }");
                sb.AppendLine();
            }

            // Generate response class
            sb.AppendLine($"    public class {responseClassName}");
            sb.AppendLine("    {");

            // Output parameters
            foreach (var param in parameters.Where(p => p.IsOutput))
            {
                var type = TypesConverterSql.MapSqlTypeToCSharp(param.ParameterType, param.IsNullable);
                sb.AppendLine($"        public {type} {param.ParameterName} {{ get; set; }}");
            }

            // Result sets
            for (int i = 0; i < resultSets.Count; i++)
            {
                var resultSet = resultSets[i];
                var resultSetClassName = $"{className}ResultSet{i + 1}";

                sb.AppendLine($"        public List<{resultSetClassName}> ResultSet{i + 1} {{ get; set; }}");
            }

            sb.AppendLine("    }");
            sb.AppendLine();

            // Generate result set classes
            for (int i = 0; i < resultSets.Count; i++)
            {
                var resultSet = resultSets[i];
                var resultSetClassName = $"{className}ResultSet{i + 1}";

                sb.AppendLine($"    public class {resultSetClassName}");
                sb.AppendLine("    {");
                foreach (var col in resultSet.Columns)
                {
                    var type = TypesConverterSql.MapSqlTypeToCSharp(col.DataType, col.IsNullable);
                    sb.AppendLine($"        public {type} {col.ColumnName} {{ get; set; }}");
                }
                sb.AppendLine("    }");
                sb.AppendLine();
            }

            sb.AppendLine("}");

            return sb.ToString();
        }


    }


}
