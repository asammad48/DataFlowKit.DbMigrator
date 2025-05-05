namespace DataFlowKit.DbMigrator.Models
{
    public class ValidateScript
    {
        public string MigrationPath { get; set; } = "";

        public string ConnectionString { get; set; } = "";
        public string Provider { get; set; } = "";
        public string Environment { get; set; } = "";
        public string StartupProject { get; set; } = "";
    }
}
