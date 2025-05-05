using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    [Verb("sp-model-gen", HelpText = "Create a new migration script.")]
    internal class GenerateStoredProcedureModelCommand
    {
        [Option("procedure", Required = true, HelpText = "Mention Stored Procedure name.")]
        public string ProcedureName { get; set; }

        [Option("output-dir", Required = false, HelpText = "Please mention Output Directory.")]
        public string OutputDirectory { get; set; }
    }
}
