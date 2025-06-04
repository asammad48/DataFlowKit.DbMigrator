using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Models;

namespace DataFlowKit.DbMigrator.MigratorFunctions
{
    public static class AddMigrationProcessor
    {
        public static int AddMigration(AddMigration opts)
        {
            if (CurrentCallInfo.IsCallFromCLI)
            {
                CurrentCallInfo.ScriptName = RunningScriptType.AddMigration;
                try
                {
                    if (string.IsNullOrEmpty(opts.Environment))
                    {
                        opts.Environment = "All";
                    }
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                    //opts.Environment = DefaultValueProvider.GetEnvironmentName(opts.Environment);
                    opts.MigrationPath = DefaultValueProvider.GetMigrationPath(opts.MigrationPath, true);
                    opts.Provider = DefaultValueProvider.GetProviderName(opts.Provider);
                    var provider = MigrationProviderFactory.Create(opts.Provider, "");
                    provider.AddMigrationAsync(opts.MigrationName, opts.Environment, opts.IsSeed, "", opts.MigrationPath).GetAwaiter().GetResult();
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed successfully.");
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process failed. ErrorMessage : {ex.Message}, Exception: {ex}");
                    return 1;
                }
                return 0;
            }
            throw new InvalidOperationException($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Operation not supported.");
        }
    }
}
