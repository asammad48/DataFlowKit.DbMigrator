using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    internal class BaseScriptCommand
    {
        [Option("provider", Required = false, HelpText = "Database provider: sqlserver | postgres")]
        public string Provider { get; set; }

        [Option("environment", Required = false, HelpText = "Environment Like QA, Test, Prod")]
        public string Environment { get; set; }
        [Option("startup", Required = true, HelpText = "Mention Startup Project Folder/Name")]
        public string StartupProject { get; set; }
    }
}
