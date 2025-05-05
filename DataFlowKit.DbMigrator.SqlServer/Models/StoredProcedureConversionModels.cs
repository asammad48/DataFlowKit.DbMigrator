namespace DataFlowKit.DbMigrator.SqlServer.Models
{
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

    public class ResultSetInfo
    {
        public int Index { get; set; }
        public List<ColumnInfo> Columns { get; set; }
    }
}
