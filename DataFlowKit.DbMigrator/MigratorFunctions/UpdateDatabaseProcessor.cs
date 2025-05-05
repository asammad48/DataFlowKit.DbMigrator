using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Models;

namespace DataFlowKit.DbMigrator.MigratorFunctions
{
    public static class UpdateDatabaseProcessor
    {
        public static int UpdateDatabase(UpdateDatabase opts)
        {
            CurrentCallInfo.ScriptName = RunningScriptType.UpdateDatabase;
            try
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                opts.Environment = DefaultValueProvider.GetEnvironmentName(opts.Environment);
                opts.MigrationPath = DefaultValueProvider.GetMigrationPath(opts.MigrationPath);
                opts.Provider = DefaultValueProvider.GetProviderName(opts.Provider);
                opts.ConnectionString = DefaultValueProvider.GetConnectionString(opts.ConnectionString);
                var provider = MigrationProviderFactory.Create(opts.Provider, opts.ConnectionString);
                var manager = new MigrationManager(provider, opts.Environment);
                var scripts = ScriptLoader.LoadScripts(opts.MigrationPath);
                manager.UpdateDatabaseAsync(scripts).GetAwaiter().GetResult();
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed successfully.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process failed. ErrorMessage: {ex.Message}");
                return 1;
            }
            return 0;
        }
    }
}
