using DataFlowKit.DbMigrator.Common.Models;
using DataFlowKit.DbMigrator.Common;
using DataFlowKit.DbMigrator.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataFlowKit.DbMigrator.Common.Interfaces;

namespace DataFlowKit.DbMigrator.MigratorFunctions
{
    internal class ImportStoredProcedureProcessor
    {
        public static int ImportStoredProcedure(ImportStoredProcedure opts)
        {
            if (CurrentCallInfo.IsCallFromCLI)
            {
                CurrentCallInfo.ScriptName = RunningScriptType.GenerateStoredProcedureModel;
                try
                {
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process started.");
                    opts.Environment = DefaultValueProvider.GetEnvironmentName(opts.Environment);
                    opts.MigrationName = string.IsNullOrEmpty(opts.MigrationName) ? opts.ProcedureName : opts.MigrationName;
                    opts.MigrationPath = DefaultValueProvider.GetMigrationPath(opts.MigrationPath, true);
                    opts.Provider = DefaultValueProvider.GetProviderName(opts.Provider);
                    opts.ConnectionString = DefaultValueProvider.GetConnectionString(opts.ConnectionString);
                    //opts.NamingConvention = DefaultValueProvider.GetSpNamingConvention(opts.NamingConvention);
                    var provider = MigrationProviderFactory.Create(opts.Provider, opts.ConnectionString);
                    var pendingMigrations = GetPendingMigrationCount(opts, provider).GetAwaiter().GetResult();
                    if (pendingMigrations > 0)
                    {

                    }
                    //provider.GenerateClassesFromStoredProc(new GenerateStoredProcedureAnalyser()
                    //{
                    //    GenerateXMLComments = opts.GenerateXMLComments,
                    //    NamingConvention = opts.NamingConvention,
                    //    OutputDirectory = opts.OutputDirectory,
                    //    StoredProcedureName = opts.ProcedureName,
                    //    UseNestedModels = opts.UseNestedModels
                    //});
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

        private static async Task<int> GetPendingMigrationCount(ImportStoredProcedure importStored, IMigrationProvider provider)
        {
            var manager = new MigrationManager(provider, importStored.Environment);
            var scripts = ScriptLoader.LoadScripts(importStored.MigrationPath);
            var totalCount = manager.GetPendingMigrationsCount(scripts).GetAwaiter().GetResult();
            return totalCount;
        }
    }
}
