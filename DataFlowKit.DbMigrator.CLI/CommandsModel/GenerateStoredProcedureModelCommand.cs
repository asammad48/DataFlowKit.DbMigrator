﻿using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    [Verb("sp-model-gen", HelpText = "Create a new migration script.")]
    internal class GenerateStoredProcedureModelCommand : BaseScriptCommand
    {
        [Option("procedure", Required = true, HelpText = "Mention Stored Procedure name.")]
        public string ProcedureName { get; set; }

        [Option("output-dir", Required = false, HelpText = "Please mention Output Directory.")]
        public string OutputDirectory { get; set; }

        [Option("convention", Required = false, HelpText = "Please mention naming convention.")]
        public string NamingConvention { get; set; }

        [Option("connection", Required = false, HelpText = "Connection string to the database.")]
        public string ConnectionString { get; set; }

        [Option("use-nested-models", Required = false, HelpText = "Generate response models with nested object types.")]
        public bool UseNestedModels { get; set; }

        [Option("gen-xml-comments", Required = false, HelpText = "Generate xml comments for generated class.")]
        public bool GenerateXMLComments { get; set; }
    }
}
