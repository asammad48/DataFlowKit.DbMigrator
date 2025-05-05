using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Models;

namespace DataFlowKit.DbMigrator.MigratorFunctions
{
    public static class AddMigrationProcessor
    {
        public static int AddMigration(AddMigration opts)
        {
            CurrentCallInfo.ScriptName = RunningScriptType.AddMigration;
            try
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                opts.Environment = DefaultValueProvider.GetEnvironmentName(opts.Environment);
                opts.MigrationPath = DefaultValueProvider.GetMigrationPath(opts.MigrationPath);
                opts.Provider = DefaultValueProvider.GetProviderName(opts.Provider);
                var provider = MigrationProviderFactory.Create(opts.Provider, "");
                provider.AddMigrationAsync(opts.MigrationName, opts.Environment, opts.IsSeed, opts.MigrationPath).GetAwaiter().GetResult();
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process failed. ErrorMessage : {ex.Message}");
                return 1;
            }
            return 0;
        }
    }
}
