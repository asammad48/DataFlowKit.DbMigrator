using CommandLine;
using DataFlowKit.DbMigrator.CLI.CommandsModel;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.MigratorFunctions;
using DataFlowKit.DbMigrator.Models;

CurrentCallInfo.IsCallFromCLI = true;
return Parser.Default.ParseArguments<
    ValidateScriptCommand,
    AddMigrationCommand,
    UpdateDatabaseCommand
>(args)
.MapResult(
    (ValidateScriptCommand opts) =>
    {
        return ValidateScriptProcessor.ValidateScript(new ValidateScript()
        {
            ConnectionString = opts.ConnectionString,
            MigrationPath = opts.MigrationPath,
            Environment = opts.Environment,
            Provider = opts.Provider
        });

    },
    (AddMigrationCommand opts) =>
    {
        return AddMigrationProcessor.AddMigration(new AddMigration()
        {
            Environment = opts.Environment,
            MigrationPath = opts.MigrationPath,
            Provider = opts.Provider,
            MigrationName = opts.MigrationName
        });
    },
    (UpdateDatabaseCommand opts) =>
    {
        return UpdateDatabaseProcessor.UpdateDatabase(new UpdateDatabase()
        {
            ConnectionString = opts.ConnectionString,
            MigrationPath = opts.MigrationPath,
            Environment = opts.Environment,
            Provider = opts.Provider
        });
    },
    errs => 1
);