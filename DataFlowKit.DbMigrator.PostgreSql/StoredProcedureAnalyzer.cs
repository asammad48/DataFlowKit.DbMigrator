using System.Data;
using System.Text;
using Dapper;
using Npgsql;

namespace DataFlowKit.DbMigrator.PostgreSql
{
    public class StoredProcAnalyzer
    {
        private readonly string _connectionString;

        public StoredProcAnalyzer(string connectionString)
        {
            _connectionString = connectionString;
        }

        public void GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "public")
        {
            var parameters = GetProcedureParameters(storedProcName, namingConvention);
            var resultSet = GetResultSetColumns(storedProcName, namingConvention);

            var classBuilder = new StringBuilder();

            // Input Model
            classBuilder.AppendLine("public class " + storedProcName + "Params");
            classBuilder.AppendLine("{");
            foreach (var p in parameters)
            {
                classBuilder.AppendLine($"    public {MapPgTypeToClr(p.ParameterType)} {p.ParameterName} {{ get; set; }}");
            }
            classBuilder.AppendLine("}");

            // ResultSet Model
            classBuilder.AppendLine();
            classBuilder.AppendLine("public class " + storedProcName + "Result");
            classBuilder.AppendLine("{");
            foreach (var col in resultSet)
            {
                classBuilder.AppendLine($"    public {MapPgTypeToClr(col.DataType)} {col.ColumnName} {{ get; set; }}");
            }
            classBuilder.AppendLine("}");

            // Output
            var output = classBuilder.ToString();

            if (!string.IsNullOrWhiteSpace(outputPath))
            {
                var filePath = Path.Combine(outputPath, storedProcName + ".cs");
                File.WriteAllText(filePath, output);
                Console.WriteLine($"Class file generated at: {filePath}");
            }
            else
            {
                Console.WriteLine(output);
            }
        }

        private List<ParameterInfo> GetProcedureParameters(string procName, string schema)
        {
            using var connection = new NpgsqlConnection(_connectionString);
            connection.Open();

            // Fetch parameter types and names
            var query = @"
                SELECT
                    p.proname AS proc_name,
                    t.typname AS data_type,
                    unnest(p.proargnames) AS param_name,
                    unnest(p.proargtypes) AS type_oid
                FROM pg_proc p
                JOIN pg_namespace n ON p.pronamespace = n.oid
                JOIN unnest(p.proargtypes) WITH ORDINALITY AS a(type_oid, ordinality) ON true
                JOIN pg_type t ON a.type_oid = t.oid
                WHERE n.nspname = @Schema AND p.proname = @ProcName;
            ";

            var result = connection.Query(query, new { Schema = schema, ProcName = procName });

            var list = new List<ParameterInfo>();
            foreach (var row in result)
            {
                list.Add(new ParameterInfo
                {
                    ParameterName = row.param_name,
                    ParameterType = row.data_type,
                    MaxLength = 0,
                    Precision = 0,
                    Scale = 0,
                    IsOutput = false,
                    IsNullable = true,
                    IsTableType = false,
                    IsUserDefined = false
                });
            }

            return list;
        }

        private List<ColumnInfo> GetResultSetColumns(string procName, string schema)
        {
            using var connection = new NpgsqlConnection(_connectionString);
            connection.Open();

            // PostgreSQL does not expose result set schema directly unless the function is written with RETURNS TABLE
            var query = $"SELECT * FROM \"{schema}\".\"{procName}\"();"; // Assumes no parameters for now

            using var command = new NpgsqlCommand(query, connection);
            using var reader = command.ExecuteReader(CommandBehavior.SchemaOnly);

            var table = reader.GetSchemaTable();
            var result = new List<ColumnInfo>();

            if (table != null)
            {
                foreach (DataRow row in table.Rows)
                {
                    result.Add(new ColumnInfo
                    {
                        ColumnName = row["ColumnName"].ToString(),
                        DataType = row["DataTypeName"].ToString(),
                        IsNullable = (bool)row["AllowDBNull"],
                        MaxLength = row["ColumnSize"] as int?,
                        Precision = row["NumericPrecision"] as byte?,
                        Scale = row["NumericScale"] as byte?
                    });
                }
            }

            return result;
        }

        private string MapPgTypeToClr(string pgType)
        {
            return pgType switch
            {
                "int4" => "int",
                "int8" => "long",
                "varchar" => "string",
                "text" => "string",
                "bool" => "bool",
                "numeric" => "decimal",
                "timestamp" => "DateTime",
                "uuid" => "Guid",
                "bytea" => "byte[]",
                _ => "string"
            };
        }
    }

    public class ParameterInfo
    {
        public string ParameterName { get; set; }
        public string ParameterType { get; set; }
        public int MaxLength { get; set; }
        public int Precision { get; set; }
        public int Scale { get; set; }
        public bool IsOutput { get; set; }
        public bool IsNullable { get; set; }
        public bool IsTableType { get; set; }
        public bool IsUserDefined { get; set; }
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
}
