using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataFlowKit.DbMigrator.MigratorFunctions
{
    public static class MarkExistingMigrationAsAppliedProcessor
    {
        public static int MarkExistingMigrationAsApplied(MarkExisitngMigrationAsApplied opts)
        {
            if (CurrentCallInfo.IsCallFromCLI)
            {
                CurrentCallInfo.ScriptName = RunningScriptType.AddMigration;
                try
                {
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                    opts.MigrationPath = DefaultValueProvider.GetMigrationPath(opts.MigrationPath, true);
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
            throw new InvalidOperationException($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Operation not supported.");
        }
    }
}
