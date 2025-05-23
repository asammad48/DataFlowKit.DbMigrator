﻿using CommandLine;

namespace DataFlowKit.DbMigrator.CLI.CommandsModel
{
    [Verb("validate-scripts", HelpText = "Validate the migration scripts.")]
    internal class ValidateScriptCommand : BaseScriptCommand
    {
        [Option("output-dir", Required = false, HelpText = "Path to the migration scripts.")]
        public string MigrationPath { get; set; }

        [Option("connection", Required = false, HelpText = "Connection string to the database.")]
        public string ConnectionString { get; set; }
    }
}
