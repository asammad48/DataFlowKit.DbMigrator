namespace DataFlowKit.DbMigrator.SqlServer.TypesConverter
{
    public static class TypesConverterSql
    {
        public static Type MapSqlTypeToDotNetType(string sqlType)
        {
            switch (sqlType.ToLower())
            {
                case "int":
                    return typeof(int);
                case "bigint":
                    return typeof(long);
                case "smallint":
                    return typeof(short);
                case "tinyint":
                    return typeof(byte);
                case "bit":
                    return typeof(bool);
                case "nvarchar":
                case "varchar":
                case "char":
                case "nchar":
                case "text":
                case "ntext":
                    return typeof(string);
                case "datetime":
                case "datetime2":
                case "date":
                case "smalldatetime":
                    return typeof(DateTime);
                case "time":
                    return typeof(TimeSpan);
                case "decimal":
                case "numeric":
                case "money":
                case "smallmoney":
                    return typeof(decimal);
                case "float":
                    return typeof(double);
                case "real":
                    return typeof(float);
                case "uniqueidentifier":
                    return typeof(Guid);
                case "binary":
                case "varbinary":
                case "image":
                    return typeof(byte[]);
                case "xml":
                    return typeof(string);
                default:
                    return typeof(object);
            }
        }

        public static string MapDotNetTypeToSqlType(string dotNetType)
        {
            return dotNetType.ToLower() switch
            {
                "string" => "nvarchar",
                "int32" => "int",
                "int64" => "bigint",
                "int16" => "smallint",
                "byte" => "tinyint",
                "boolean" => "bit",
                "datetime" => "datetime",
                "decimal" => "decimal",
                "double" => "float",
                "single" => "real",
                "guid" => "uniqueidentifier",
                "byte[]" => "varbinary",
                _ => "nvarchar" // Default fallback
            };
        }
        public static string MapSqlTypeToCSharp(string sqlType, bool isNullable)
        {
            string type = sqlType.ToLower() switch
            {
                "int" => "int",
                "bigint" => "long",
                "smallint" => "short",
                "tinyint" => "byte",
                "bit" => "bool",
                "datetime" => "DateTime",
                "datetime2" => "DateTime",
                "date" => "DateTime",
                "time" => "TimeSpan",
                "datetimeoffset" => "DateTimeOffset",
                "decimal" => "decimal",
                "numeric" => "decimal",
                "money" => "decimal",
                "smallmoney" => "decimal",
                "float" => "double",
                "real" => "float",
                "uniqueidentifier" => "Guid",
                "varchar" => "string",
                "nvarchar" => "string",
                "char" => "string",
                "nchar" => "string",
                "text" => "string",
                "ntext" => "string",
                "binary" => "byte[]",
                "varbinary" => "byte[]",
                "image" => "byte[]",
                "xml" => "string",
                _ => "object"
            };

            return isNullable && type != "string" && type != "object" && !type.EndsWith("[]")
                ? $"{type}?" : type;
        }
    }
}
