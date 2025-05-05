namespace DataFlowKit.DbMigrator.Models
{
    public class AddMigration
    {
        public string MigrationName { get; set; } = "";
        public string MigrationPath { get; set; } = "";
        public string Provider { get; set; } = "";
        public string Environment { get; set; } = "";
        public bool IsSeed { get; set; }
    }
}
