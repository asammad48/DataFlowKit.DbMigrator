using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    [Verb("remove-migration", HelpText = "Remove a migration script.")]
    public class RemoveMigrationCommand
    {
        [Option("name", Required = true, HelpText = "Name of the new migration.")]
        public string MigrationName { get; set; }

        [Option("output-dir", Required = false, HelpText = "Path to save the migration script.")]
        public string OutputDirectory { get; set; }

        [Option("connection", Required = false, HelpText = "Connection string to the database.")]
        public string ConnectionString { get; set; }

        [Option("startup", Required = true, HelpText = "Mention Startup Project Folder/Name")]
        public string StartupProject { get; set; }

        [Option("provider", Required = true, HelpText = "Mention Startup Project Folder/Name")]
        public string Provider { get; set; }
    }
}
