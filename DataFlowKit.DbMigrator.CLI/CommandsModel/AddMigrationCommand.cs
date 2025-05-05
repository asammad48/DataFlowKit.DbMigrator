using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    [Verb("add-migration", HelpText = "Create a new migration script.")]
    internal class AddMigrationCommand : BaseScriptCommand
    {
        [Option('n', "name", Required = true, HelpText = "Name of the new migration.")]
        public string MigrationName { get; set; }

        [Option('p', "path", Required = false, HelpText = "Path to save the migration script.")]
        public string MigrationPath { get; set; }
    }
}
