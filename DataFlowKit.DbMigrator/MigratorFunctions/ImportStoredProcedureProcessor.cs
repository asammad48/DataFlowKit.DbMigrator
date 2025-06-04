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
                        var pendingMigrationResponse = userDecisions($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: {pendingMigrations} migration(s) are pending. Would you like to apply them now? (yes/no)");
                        if (pendingMigrationResponse?.ToLower() != "yes")
                        {
                            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process aborted by user.");
                            return 0;
                        }
                        //var manager = new MigrationManager(provider, opts.Environment);
                        //var scripts = ScriptLoader.LoadScripts(opts.MigrationPath);
                        //manager.UpdateDatabaseAsync(scripts).GetAwaiter().GetResult();
                        UpdateDatabase(opts, provider).GetAwaiter().GetResult();
                    }
                    var storedProcedureText = provider.GetStoredProcedureText(opts.ProcedureName).GetAwaiter().GetResult();
                    provider.AddMigrationAsync(opts.MigrationName, opts.Environment, false, storedProcedureText, opts.MigrationPath).GetAwaiter().GetResult();
                    UpdateDatabase(opts, provider).GetAwaiter().GetResult();
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Stored procedure '{opts.ProcedureName}' has been successfully imported as migration '{opts.MigrationName}' in the '{opts.Environment}' environment.");
                    var spModelGenResponse = userDecisions($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Would you like to generate the request and response models as well? (yes/no)");
                    if (spModelGenResponse?.ToLower() != "yes")
                    {
                        Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed successfully without generating models.");
                        return 0;
                    }
                    var spGenResponse = GetStoredProcedureGenParamters();
                    provider.GenerateClassesFromStoredProc(new GenerateStoredProcedureAnalyser()
                    {
                        GenerateXMLComments = spGenResponse.genXmlComments,
                        NamingConvention = spGenResponse.namingConvention,
                        OutputDirectory = spGenResponse.outputPath,
                        StoredProcedureName = opts.ProcedureName,
                        UseNestedModels = spGenResponse.isNestedModel
                    });
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Process completed successfully. Stored Procedure Models have been generated.");
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
        private static string userDecisions(string message)
        {
            Console.WriteLine(message);
            return Console.ReadLine();
        }

        private static async Task UpdateDatabase(ImportStoredProcedure importStored, IMigrationProvider provider)
        {
            var manager = new MigrationManager(provider, importStored.Environment);
            var scripts = ScriptLoader.LoadScripts(importStored.MigrationPath);
            manager.UpdateDatabaseAsync(scripts).GetAwaiter().GetResult();
        }
        private static (bool genXmlComments, bool isNestedModel, string outputPath, string namingConvention) GetStoredProcedureGenParamters()
        {
            (bool genXmlComments, bool isNestedModel, string outputPath, string namingConvention) tupleResult = default;

            var outputPathResponse = userDecisions($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Would you like to provide the EntityFolder path manually? If not, press Enter to use the default from AppSettings.");
            tupleResult.outputPath = DefaultValueProvider.GetStoredProcedureModelPath(outputPathResponse, true);

            var genXmlComments = userDecisions($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Would you like to include XML comments in the Request and Response Models of the Stored Procedure? (yes/no)");
            if (genXmlComments?.ToLower() == "yes")
            {
                tupleResult.genXmlComments = true;
            }

            var isNestedModel = userDecisions($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Would you like to generate a Nested Response Model for the Stored Procedure? (yes/no)");
            if (isNestedModel?.ToLower() == "yes")
            {
                tupleResult.isNestedModel = true;
            }

            var namingConvetion = userDecisions($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Would you like to specify a custom naming convention for the Stored Procedure Model? If not, press Enter to use the one from AppSettings.");
            tupleResult.namingConvention = DefaultValueProvider.GetSpNamingConvention(namingConvetion);

            return tupleResult;

        }
    }
}
