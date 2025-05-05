using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    [Verb("update-database", HelpText = "Apply all pending migrations to the database.")]
    internal class UpdateDatabaseCommand : BaseScriptCommand
    {
        [Option('c', "connection", Required = false, HelpText = "Connection string to the database.")]
        public string ConnectionString { get; set; }

        [Option('p', "path", Required = false, HelpText = "Path to the migration scripts.")]
        public string MigrationPath { get; set; }
    }
}
