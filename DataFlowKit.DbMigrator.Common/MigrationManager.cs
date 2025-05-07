using DataFlowKit.DbMigrator.Common.Interfaces;
using DataFlowKit.DbMigrator.Common.Models;

namespace DataFlowKit.DbMigrator.Common
{
    public class MigrationManager
    {
        private readonly IMigrationProvider _provider;
        private readonly string _environment;

        public MigrationManager(IMigrationProvider provider, string environment)
        {
            _provider = provider ?? throw new ArgumentNullException(nameof(provider));
            _environment = environment ?? throw new ArgumentNullException(nameof(environment));
        }

        public async Task UpdateDatabaseAsync(List<MigrationScript> allScripts)
        {
            if (allScripts == null || allScripts.Count == 0)
                return;

            await _provider.EnsureMigrationTableExistsAsync();

            var appliedMigrations = await _provider.GetAppliedMigrationsAsync();
            var appliedSet = new HashSet<string>(appliedMigrations.Select(m => m.FileName));

            var pendingScripts = allScripts
                .Where(s => !appliedSet.Contains(s.FileName)) // skip already applied
                .Where(ShouldRunInEnvironment)
                .OrderBy(s => s.FileName)
                .ToList();
            if (pendingScripts.Count > 0)
            {
                await _provider.ValidateScriptsAsync(pendingScripts);
                await _provider.ApplyMigrationsAsync(pendingScripts);
                await _provider.UpdateMigrationRecordsAsync(pendingScripts);
                return;
            }
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: No Pending Migration Script found.");
        }

        public async Task ValidateScriptsAsync(List<MigrationScript> allScripts)
        {
            if (allScripts == null || allScripts.Count == 0)
                return;

            await _provider.EnsureMigrationTableExistsAsync();

            var appliedMigrations = await _provider.GetAppliedMigrationsAsync();
            var appliedSet = new HashSet<string>(appliedMigrations.Select(m => m.FileName));

            var pendingScripts = allScripts
                .Where(s => !appliedSet.Contains(s.FileName)) // skip already applied
                .Where(ShouldRunInEnvironment)
                .OrderBy(s => s.FileName)
                .ToList();
            if (pendingScripts.Count > 0)
            {
                _provider.ValidateScriptsAsync(pendingScripts).GetAwaiter().GetResult();
                return;
            }
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: No Pending Migration Script found.");
            return;
        }

        public async Task RemoveMigrationAsync(string filePath)
        {
            await _provider.EnsureMigrationTableExistsAsync();
            var appliedMigrations = await _provider.GetAppliedMigrationsAsync();
            var appliedSet = new HashSet<string>(appliedMigrations.Select(m => m.FileName));
            var fileName = Path.GetFileName(filePath);
            var appliedScript = appliedSet.Contains(Path.GetFileName(fileName));
            if (!appliedScript)
            {
                File.Delete(fileName);
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration file deleted successfully.");
                return;
            }
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration file is already applied. So it cannot be deleted.");
            return;
        }

        public async Task MarkExistingMigrationAsAppliedAsync(string filePath)
        {
            await _provider.EnsureMigrationTableExistsAsync();
            var appliedMigrations = await _provider.GetAppliedMigrationsAsync();
            var appliedSet = new HashSet<string>(appliedMigrations.Select(m => m.FileName));
            var fileName = Path.GetFileName(filePath);
            var appliedScript = appliedSet.Contains(Path.GetFileName(fileName));
            if (!appliedScript)
            {
                await _provider.UpdateSingleMigrationRecordsAsync(fileName, "");
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration file {filePath} marked as applied.");
                return;
            }
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration file is already marked as applied.");
            return;
        }

        private bool ShouldRunInEnvironment(MigrationScript script)
        {
            return script.Environments.Contains("All", StringComparer.OrdinalIgnoreCase)
                || script.Environments.Contains(_environment, StringComparer.OrdinalIgnoreCase);
        }
    }

}
