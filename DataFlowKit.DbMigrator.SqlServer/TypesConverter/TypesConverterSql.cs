using DataFlowKit.DbMigrator.SqlServer.Models;
using System.Data;

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


        public static object GetDummyValue(ParameterInfo param)
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

        public static SqlDbType GetSqlDbType(string sqlType)
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
    }
}
