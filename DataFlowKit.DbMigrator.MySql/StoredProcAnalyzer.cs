using System.Data;
using System.Text;
using Dapper;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Common;
using MySql.Data.MySqlClient;
using ZstdSharp.Unsafe;

namespace DataFlowKit.DbMigrator.MySql
{
    public class StoredProcAnalyzer
    {
        private readonly string _connectionString;

        public StoredProcAnalyzer(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "GeneratedModels", bool useNestedModels = true, bool generateXmlComments = false)
        {
            try
            {
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
                        relativePathOfEntityFolder = outputPath;
                    }
                }
                var classCode = GenerateClassFile(storedProcName, parameters, resultSets, namingConvention, relativePathOfEntityFolder, useNestedModels, generateXmlComments);

                var fileName = $"{ToPascalCase(storedProcName)}{namingConvention}.cs";
                var path = Path.Combine(outputPath, fileName);

                Directory.CreateDirectory(outputPath);
                //File.WriteAllText(path, classCode);
                DirectorySearcher.WriteTextToFile(path, classCode);
                Console.WriteLine($"Successfully generated models for {storedProcName} at {path}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error analyzing {storedProcName}: {ex.Message}");
                throw;
            }
        }

        private string ToPascalCase(string name)
        {
            if (string.IsNullOrEmpty(name)) return name;

            var parts = name.Split(new[] { '_', ' ' }, StringSplitOptions.RemoveEmptyEntries);
            return string.Join("", parts.Select(p =>
                p.Length > 0 ? char.ToUpper(p[0]) + p.Substring(1).ToLower() : ""));
        }

        private IEnumerable<ParameterInfo> GetStoredProcParameters(string storedProcName)
        {
            using var connection = new MySqlConnection(_connectionString);
            // Modified query to work with MySQL's information_schema
            var parameters = new
            {
                ProcName = storedProcName.Trim(),
                DatabaseName = connection.Database // Gets the DB name from the connection string
            };

            var result = connection.Query<ParameterInfo>(@"
                        SELECT 
                            PARAMETER_NAME AS ParameterName,
                            DATA_TYPE AS ParameterType,
                            CHARACTER_MAXIMUM_LENGTH AS MaxLength,
                            IFNULL(NUMERIC_PRECISION, 0) AS `Precision`,
                            IFNULL(NUMERIC_SCALE, 0) AS Scale,
                            IF(PARAMETER_MODE = 'OUT', TRUE, FALSE) AS IsOutput
                        FROM information_schema.PARAMETERS
                        WHERE SPECIFIC_NAME = @ProcName
                        AND SPECIFIC_SCHEMA = @DatabaseName  -- Filter by database name
                        ORDER BY ORDINAL_POSITION;", parameters);
            return result;

        }

        private List<ResultSetInfo> GetResultSetStructures(string storedProcName, IEnumerable<ParameterInfo> parameters)
        {
            var resultSets = new List<ResultSetInfo>();

            using var connection = new MySqlConnection(_connectionString);
            connection.Open();

            using var command = new MySqlCommand(storedProcName, connection)
            {
                CommandType = CommandType.StoredProcedure
            };

            // Add parameters with default null values
            foreach (var param in parameters.Where(p => !p.IsOutput))
            {
                var dbType = MapMySqlTypeToDbType(param.ParameterType);
                var sqlParam = new MySqlParameter(param.ParameterName, dbType)
                {
                    Value = DBNull.Value,
                    Direction = ParameterDirection.Input
                };
                command.Parameters.Add(sqlParam);
            }

            // Add output parameters
            foreach (var param in parameters.Where(p => p.IsOutput))
            {
                var dbType = MapMySqlTypeToDbType(param.ParameterType);
                var sqlParam = new MySqlParameter(param.ParameterName, dbType)
                {
                    Direction = ParameterDirection.Output
                };
                command.Parameters.Add(sqlParam);
            }

            using var reader = command.ExecuteReader();
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
                        DataType = MapCSharpTypeToMySqlType(((Type)row["DataType"]).Name, (bool)row["AllowDBNull"]),
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

        private string GenerateClassFile(string storedProcName, IEnumerable<ParameterInfo> parameters,
            List<ResultSetInfo> resultSets, string namingConvention, string nameSpaceName, bool useNestedModels = false, bool useXmlComments = true)
        {
            var className = ToPascalCase(storedProcName);
            var requestClassName = $"{className}Request{namingConvention}";
            var responseClassName = $"{className}Response{namingConvention}";
            var sb = new StringBuilder();

            // Header
            if (useXmlComments)
            {
                sb.AppendLine("// <auto-generated>");
                sb.AppendLine("//     This code was generated by a tool.");
                sb.AppendLine("//     Changes to this file may cause incorrect behavior and will be lost if");
                sb.AppendLine("//     the code is regenerated.");
                sb.AppendLine("// </auto-generated>");
                sb.AppendLine();
            }

            sb.AppendLine("using System;");
            sb.AppendLine("using System.Collections.Generic;");
            sb.AppendLine();
            sb.AppendLine($"namespace {nameSpaceName.Replace('/', '.')}");
            sb.AppendLine("{");

            // Request Model
            if (useXmlComments)
            {
                sb.AppendLine($"    /// <summary>");
                sb.AppendLine($"    /// Request model for stored procedure {storedProcName}");
                sb.AppendLine($"    /// </summary>");
            }
            sb.AppendLine($"    public class {requestClassName}");
            sb.AppendLine("    {");
            foreach (var param in parameters.Where(p => !p.IsOutput))
            {
                var type = MapMySqlTypeToCSharp(param.ParameterType, param.IsNullable);
                var name = ToPascalCase(param.ParameterName.TrimStart('@'));
                if (useXmlComments)
                {
                    var summary = $"/// <summary>Parameter {param.ParameterName} of type {param.ParameterType}</summary>";

                    sb.AppendLine($"        {summary}");
                }
                sb.AppendLine($"        public {type} {name} {{ get; set; }}");
                sb.AppendLine();
            }
            sb.AppendLine("    }");
            sb.AppendLine();


            if (parameters.Where(p => p.IsOutput).Count() > 0 || (useNestedModels && resultSets.Count > 0))
            {
                // Response Model
                if (useXmlComments)
                {
                    sb.AppendLine($"    /// <summary>");
                    sb.AppendLine($"    /// Response model for stored procedure {storedProcName}");
                    sb.AppendLine($"    /// </summary>");
                }
                sb.AppendLine($"    public class {responseClassName}");
                sb.AppendLine("    {");

                // Output parameters
                foreach (var param in parameters.Where(p => p.IsOutput))
                {
                    var type = MapMySqlTypeToCSharp(param.ParameterType, param.IsNullable);
                    var name = ToPascalCase(param.ParameterName.TrimStart('@'));
                    if (useXmlComments)
                    {
                        var summary = $"/// <summary>Output parameter {param.ParameterName} of type {param.ParameterType}</summary>";

                        sb.AppendLine($"        {summary}");
                    }
                    sb.AppendLine($"        public {type} {name} {{ get; set; }}");
                    sb.AppendLine();
                }
                if (useNestedModels)
                {
                    // Result sets
                    for (int i = 0; i < resultSets.Count; i++)
                    {
                        var resultClassName = $"{className}ResultSet{i + 1}";
                        if (useXmlComments)
                        {
                            var summary = $"/// <summary>Result set #{i + 1} from stored procedure {storedProcName}</summary>";
                            sb.AppendLine($"        {summary}");
                        }
                        sb.AppendLine($"        public List<{resultClassName}> ResultSet{i + 1} {{ get; set; }} = new List<{resultClassName}>();");
                        sb.AppendLine();
                    }
                }

                sb.AppendLine("    }");
                sb.AppendLine();
            }


            // Result set models
            for (int i = 0; i < resultSets.Count; i++)
            {
                var resultClassName = $"{className}ResultSet{i + 1}";
                if (useXmlComments)
                {
                    sb.AppendLine($"    /// <summary>");
                    sb.AppendLine($"    /// Model for result set #{i + 1} of stored procedure {storedProcName}");
                    sb.AppendLine($"    /// </summary>");
                }
                sb.AppendLine($"    public class {resultClassName}");
                sb.AppendLine("    {");
                foreach (var col in resultSets[i].Columns)
                {
                    var type = MapMySqlTypeToCSharp(col.DataType, col.IsNullable);
                    var name = ToPascalCase(col.ColumnName);
                    if (useXmlComments)
                    {
                        var summary = $"/// <summary>Column {col.ColumnName} of type {col.DataType}</summary>";
                        sb.AppendLine($"        {summary}");
                    }
                    sb.AppendLine($"        public {type} {name} {{ get; set; }}");
                    sb.AppendLine();
                }
                sb.AppendLine("    }");
                sb.AppendLine();
            }

            sb.AppendLine("}");
            return sb.ToString();
        }

        private DbType MapMySqlTypeToDbType(string sqlType)
        {
            return sqlType.ToLower() switch
            {
                "int" => DbType.Int32,
                "bigint" => DbType.Int64,
                "varchar" or "text" or "char" => DbType.String,
                "datetime" or "timestamp" => DbType.DateTime,
                "date" => DbType.Date,
                "decimal" => DbType.Decimal,
                "double" => DbType.Double,
                "float" => DbType.Single,
                "bit" or "boolean" => DbType.Boolean,
                "binary" or "varbinary" => DbType.Binary,
                _ => DbType.Object
            };
        }

        private string MapMySqlTypeToCSharp(string sqlType, bool isNullable)
        {
            string baseType = sqlType.ToLower() switch
            {
                "int" => "int",
                "bigint" => "long",
                "varchar" or "text" or "char" => "string",
                "datetime" or "timestamp" => "DateTime",
                "date" => "DateTime",
                "decimal" => "decimal",
                "double" => "double",
                "float" => "float",
                "bit" or "boolean" => "bool",
                "binary" or "varbinary" => "byte[]",
                _ => "object"
            };

            if (baseType == "string" || baseType == "byte[]" || baseType == "object")
                return baseType;

            return isNullable ? baseType + "?" : baseType;
        }
        private string MapCSharpTypeToMySqlType(string csharpTypeName, bool isNullable)
        {
            return csharpTypeName switch
            {
                "Int16" => "SMALLINT",
                "Int32" => "INT",
                "Int64" => "BIGINT",
                "Byte" => "TINYINT",
                "Decimal" => "DECIMAL",
                "Double" => "DOUBLE",
                "Single" => "FLOAT",
                "Boolean" => "BIT",
                "String" => "VARCHAR",
                "DateTime" => "DATETIME",
                "Byte[]" => "VARBINARY",
                _ => "TEXT"
            };
        }

    }

    public class ParameterInfo
    {
        public string ParameterName { get; set; }
        public string ParameterType { get; set; }
        public int? MaxLength { get; set; }
        public int? Precision { get; set; }
        public int? Scale { get; set; }
        public bool IsOutput { get; set; }
        public bool IsNullable { get; set; }
    }

    public class ColumnInfo
    {
        public string ColumnName { get; set; }
        public string DataType { get; set; }
        public bool IsNullable { get; set; }
        public int? MaxLength { get; set; }
        public byte? Precision { get; set; }
        public byte? Scale { get; set; }
    }

    public class ResultSetInfo
    {
        public int Index { get; set; }
        public List<ColumnInfo> Columns { get; set; } = new List<ColumnInfo>();
    }
}