namespace DataFlowKit.DbMigrator.Common.Models
{
    public class MigrationScript
    {
        public string FileName { get; set; }
        public string Sql { get; set; }
        public bool IsSeed { get; set; }
        public List<string> Environments { get; set; } = new();
        public string GitHash { get; set; }
    }
}
