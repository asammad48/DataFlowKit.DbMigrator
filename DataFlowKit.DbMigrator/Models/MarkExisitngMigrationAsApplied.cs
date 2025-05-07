namespace DataFlowKit.DbMigrator.Models
{
    public class MarkExisitngMigrationAsApplied
    {
        public string MigrationName { get; set; } = "";
        public string MigrationPath { get; set; } = "";
        public string ConnectionString { get; set; } = "";
        public string StartupProject { get; set; } = "";
        public string Provider { get; set; } = "";
    }

}
