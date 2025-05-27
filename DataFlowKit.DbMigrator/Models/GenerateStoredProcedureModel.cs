namespace DataFlowKit.DbMigrator.Models
{
    public class GenerateStoredProcedureModel
    {
        public string Environment { get; set; } = "";
        public string Provider { get; set; } = "";
        public string StartupProject { get; set; } = "";
        public string ProcedureName { get; set; } = "";
        public string OutputDirectory { get; set; } = "";
        public string ConnectionString { get; set; } = "";
        public string NamingConvention { get; set; } = "";
        public bool UseNestedModels { get; set; } = false;
        public bool GenerateXMLComments { get; set; } = false;
    }
}
