namespace DataFlowKit.DbMigrator.Common.Models
{
    public class MigrationHistory
    {
        public string FileName { get; set; }
        public DateTime AppliedOn { get; set; }
        public string GitHash { get; set; }
    }
}
