using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    [Verb("update-database", HelpText = "Apply all pending migrations to the database.")]
    internal class UpdateDatabaseCommand : BaseScriptCommand
    {
        [Option("connection", Required = false, HelpText = "Connection string to the database.")]
        public string ConnectionString { get; set; }

        [Option("output-dir", Required = false, HelpText = "Path to the migration scripts.")]
        public string MigrationPath { get; set; }
    }
}
