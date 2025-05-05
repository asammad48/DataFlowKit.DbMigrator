using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Models;

namespace DataFlowKit.DbMigrator.MigratorFunctions
{

    public static class GenerateStoredProcedureModelProcessor
    {
        public static int GenerateStoredProcedureModel(GenerateStoredProcedureModel opts)
        {
            if (CurrentCallInfo.IsCallFromCLI)
            {
                CurrentCallInfo.ScriptName = RunningScriptType.GenerateStoredProcedureModel;
                try
                {
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                    opts.Environment = DefaultValueProvider.GetEnvironmentName(opts.Environment);
                    opts.OutputDirectory = DefaultValueProvider.GetStoredProcedureModelPath(opts.OutputDirectory);
                    opts.Provider = DefaultValueProvider.GetProviderName(opts.Provider);
                    opts.ConnectionString = DefaultValueProvider.GetConnectionString(opts.ConnectionString);
                    opts.NamingConvention = DefaultValueProvider.GetSpNamingConvention(opts.NamingConvention);
                    var provider = MigrationProviderFactory.Create(opts.Provider, opts.ConnectionString);
                    provider.GenerateClassesFromStoredProc(opts.ProcedureName, opts.OutputDirectory, opts.NamingConvention);
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed successfully.");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process failed. ErrorMessage: {ex.Message}");
                    return 1;
                }
                return 0;
            }
            throw new InvalidOperationException($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Operation not supported.");
        }
    }
}
