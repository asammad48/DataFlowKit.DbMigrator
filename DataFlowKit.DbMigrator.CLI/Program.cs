using CommandLine;
using DataFlowKit.DbMigrator.CLI.CommandsModel;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.MigratorFunctions;
using DataFlowKit.DbMigrator.Models;

CurrentCallInfo.IsCallFromCLI = true;
return Parser.Default.ParseArguments<
    ValidateScriptCommand,
    AddMigrationCommand,
    UpdateDatabaseCommand,
    GenerateStoredProcedureModelCommand,
    RemoveMigrationCommand,
    MarkExisitngMigrationAsAppliedCommand
>(args)
.MapResult(
    (ValidateScriptCommand opts) =>
    {
        CurrentCallInfo.StartupProject = opts.StartupProject;
        return ValidateScriptProcessor.ValidateScript(new ValidateScript()
        {
            ConnectionString = opts.ConnectionString,
            MigrationPath = opts.MigrationPath,
            Environment = opts.Environment,
            Provider = opts.Provider,
            StartupProject = opts.StartupProject,
        });
    },
    (AddMigrationCommand opts) =>
    {
        CurrentCallInfo.StartupProject = opts.StartupProject;
        return AddMigrationProcessor.AddMigration(new AddMigration()
        {
            Environment = opts.Environment,
            MigrationPath = opts.OutputDirectory,
            Provider = opts.Provider,
            MigrationName = opts.MigrationName,
            StartupProject = opts.StartupProject,
        });
    },
    (UpdateDatabaseCommand opts) =>
    {
        CurrentCallInfo.StartupProject = opts.StartupProject;
        return UpdateDatabaseProcessor.UpdateDatabase(new UpdateDatabase()
        {
            ConnectionString = opts.ConnectionString,
            MigrationPath = opts.MigrationPath,
            Environment = opts.Environment,
            Provider = opts.Provider,
            StartupProject = opts.StartupProject,
        });
    },
    (GenerateStoredProcedureModelCommand opts) =>
    {
        CurrentCallInfo.StartupProject = opts.StartupProject;
        return GenerateStoredProcedureModelProcessor.GenerateStoredProcedureModel(new GenerateStoredProcedureModel()
        {
            Environment = opts.Environment,
            OutputDirectory = opts.OutputDirectory,
            ProcedureName = opts.ProcedureName,
            Provider = opts.Provider,
            StartupProject = opts.StartupProject,
            NamingConvention = opts.NamingConvention,
            ConnectionString = opts.ConnectionString,
            UseNestedModels = opts.UseNestedModels,
            GenerateXMLComments = opts.GenerateXMLComments
        });
    },
    (RemoveMigrationCommand opts) =>
    {
        CurrentCallInfo.StartupProject = opts.StartupProject;
        return RemoveMigrationProcessor.RemoveMigration(new RemoveMigration()
        {
            MigrationPath = opts.OutputDirectory,
            Provider = opts.Provider,
            MigrationName = opts.MigrationName,
            StartupProject = opts.StartupProject,
            ConnectionString = opts.ConnectionString
        });
    },
    (MarkExisitngMigrationAsAppliedCommand opts) =>
    {
        CurrentCallInfo.StartupProject = opts.StartupProject;
        return MarkExistingMigrationAsAppliedProcessor.MarkExistingMigrationAsApplied(new MarkExisitngMigrationAsApplied()
        {
            MigrationPath = opts.OutputDirectory,
            Provider = opts.Provider,
            MigrationName = opts.MigrationName,
            StartupProject = opts.StartupProject,
            ConnectionString = opts.ConnectionString
        });
    },
    errs => 1
);