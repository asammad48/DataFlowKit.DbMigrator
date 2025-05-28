using Dapper;
using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.SqlServer.Models;
using DataFlowKit.DbMigrator.SqlServer.TypesConverter;
using Microsoft.Data.SqlClient;
using Newtonsoft.Json;
using System.Data;
using System.IO;
using System.Text;
using System.Text.Json.Serialization;
using System.Text.RegularExpressions;

namespace DataFlowKit.DbMigrator.SqlServer
{

    public class StoredProcAnalyzer
    {
        private readonly string _connectionString;

        public StoredProcAnalyzer(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "DBO", bool useNestedModels = true, bool generateXmlComments = false)
        {
            try
            {
                var spDefinition = GetStoredProcDefinition(storedProcName);
                var parameters = GetStoredProcParameters(storedProcName);
                var resultSets = GetResultSetStructures(storedProcName, parameters);
                string relativePathOfEntityFolder = "GeneratedModels";
                if (CurrentCallInfo.IsEntityDirectoryRelativePath)
                {
                    if (string.IsNullOrEmpty(outputPath))
                    {
                        relativePathOfEntityFolder = $"{DefaultValueProvider.GetSPProjectName()}/{DefaultValueProvider.GetSPFolderName()}";
                    }
                    else
                    {
                        relativePathOfEntityFolder = Path.GetRelativePath(Directory.GetCurrentDirectory(), outputPath);
                    }
                }
                var classCode = GenerateClassFile(storedProcName, parameters, resultSets, relativePathOfEntityFolder, useNestedModels, generateXmlComments);
                DirectorySearcher.WriteTextToFile(Path.Combine(outputPath, $"{SanitizeName(storedProcName)}{namingConvention}.cs"), classCode);
                //File.WriteAllText(Path.Combine(outputPath, $"{SanitizeName(storedProcName)}{namingConvention}.cs"), classCode);
            }
            catch (Exception ex)
            {
                throw;
            }

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
                    command.Parameters.AddWithValue(param.ParameterName, TypesConverterSql.GetDummyValue(param));
                }
            }
            foreach (var param in parameters.Where(p => p.IsOutput))
            {
                command.Parameters.Add(new SqlParameter
                {
                    ParameterName = param.ParameterName,
                    Direction = ParameterDirection.Output,
                    SqlDbType = TypesConverterSql.GetSqlDbType(param.ParameterType)
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

        private string GenerateClassFile(string storedProcName,
                               IEnumerable<ParameterInfo> parameters,
                               List<ResultSetInfo> resultSets, string relativePathOfEntityFolder, bool useNestedModels = false, bool useXmlComments = true)
        {
            var className = SanitizeName(storedProcName);
            var requestClassName = $"{className}Request";
            var responseClassName = $"{className}Response";

            var sb = new StringBuilder();

            parameters.ToList().ForEach(x => x.ParameterName = x.ParameterName.Replace("@", ""));

            resultSets.ForEach(x => x.Columns.ToList().ForEach(y => y.ColumnName = string.IsNullOrEmpty(y.ColumnName) ? y.ColumnName : char.ToUpper(y.ColumnName[0]) + y.ColumnName.Substring(1)));

            // Add header
            if (useXmlComments)
            {
                sb.AppendLine("// Auto-generated code");
                sb.AppendLine("// Generated from stored procedure: " + storedProcName);
            }
            sb.AppendLine("using System;");
            sb.AppendLine("using System.Collections.Generic;");
            sb.AppendLine("using System.Data;");
            sb.AppendLine();
            sb.AppendLine($"namespace {Regex.Replace(relativePathOfEntityFolder, @"[\\/]+", ".")}");
            sb.AppendLine("{");

            // Check if we need to generate request class (has input parameters)
            bool hasInputParameters = parameters.Any(p => !p.IsOutput && !p.IsTableType);
            bool hasTableParameters = parameters.Any(p => p.IsTableType);

            if (hasInputParameters || hasTableParameters)
            {
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
            }

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

            // Check if we need to generate response class (has output parameters or result sets)
            bool hasOutputParameters = parameters.Any(p => p.IsOutput);
            bool hasResultSets = resultSets.Any();

            if (hasOutputParameters || (hasResultSets && useNestedModels))
            {
                // Generate response class
                sb.AppendLine($"    public class {responseClassName}");
                sb.AppendLine("    {");

                // Output parameters
                foreach (var param in parameters.Where(p => p.IsOutput))
                {
                    var type = TypesConverterSql.MapSqlTypeToCSharp(param.ParameterType, param.IsNullable);
                    sb.AppendLine($"        public {type} {param.ParameterName} {{ get; set; }}");
                }

                if (useNestedModels)
                {
                    // Result sets
                    for (int i = 0; i < resultSets.Count; i++)
                    {
                        var resultSet = resultSets[i];
                        var resultSetClassName = $"{className}ResultSet{i + 1}";

                        sb.AppendLine($"        public List<{resultSetClassName}> ResultSet{i + 1} {{ get; set; }}");
                    }
                }
                sb.AppendLine("    }");
                sb.AppendLine();
            }

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
                if (i < resultSets.Count - 1) sb.AppendLine();
            }

            sb.AppendLine("}");

            return sb.ToString();
        }



    }


}
