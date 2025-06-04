using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Models;

namespace DataFlowKit.DbMigrator.MigratorFunctions
{
    public static class MarkExistingMigrationAsAppliedProcessor
    {
        public static int MarkApplied(List<string> fileNames, string migrationPath = "")
        {
            CurrentCallInfo.ScriptName = RunningScriptType.MarkMigrationAsApplied;
            try
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                migrationPath = DefaultValueProvider.GetMigrationPath(migrationPath, false);
                var configProvider = DefaultValueProvider.GetProviderName("");
                var connectionString = DefaultValueProvider.GetConnectionString("");
                var provider = MigrationProviderFactory.Create(configProvider, connectionString);
                var manager = new MigrationManager(provider, "");
                foreach (var migrationName in fileNames)
                {
                    var fileExists = ScriptLoader.ValidateFilePath(Path.Combine(migrationPath, migrationName));
                    if (fileExists)
                    {
                        manager.MarkExistingMigrationAsAppliedAsync(Path.Combine(migrationPath, migrationName)).GetAwaiter().GetResult();
                    }
                }

                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process failed. ErrorMessage : {ex.Message}, Exception: {ex}");
                return 1;
            }
            return 0;
        }
        public static int MarkExistingMigrationAsApplied(MarkExisitngMigrationAsApplied opts)
        {

            CurrentCallInfo.ScriptName = RunningScriptType.MarkMigrationAsApplied;
            try
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                opts.MigrationPath = DefaultValueProvider.GetMigrationPath(opts.MigrationPath, false);
                opts.Provider = DefaultValueProvider.GetProviderName(opts.Provider);
                opts.ConnectionString = DefaultValueProvider.GetConnectionString(opts.ConnectionString);
                var provider = MigrationProviderFactory.Create(opts.Provider, opts.ConnectionString);
                var manager = new MigrationManager(provider, "");
                var fileExists = ScriptLoader.ValidateFilePath(Path.Combine(opts.MigrationPath, opts.MigrationName));
                if (fileExists)
                {
                    manager.MarkExistingMigrationAsAppliedAsync(Path.Combine(opts.MigrationPath, opts.MigrationName)).GetAwaiter().GetResult();
                }
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed.");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process failed. ErrorMessage : {ex.Message}, Exception: {ex}");
                return 1;
            }
            return 0;

        }
    }
}
