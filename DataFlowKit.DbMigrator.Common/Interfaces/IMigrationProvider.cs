using DataFlowKit.DbMigrator.Common.Models;

namespace DataFlowKit.DbMigrator.Common.Interfaces
{
    public interface IMigrationProvider
    {
        Task EnsureMigrationTableExistsAsync();
        Task<List<MigrationHistory>> GetAppliedMigrationsAsync();
        Task ValidateScriptsAsync(IEnumerable<MigrationScript> scripts);
        Task ApplyMigrationsAsync(IEnumerable<MigrationScript> scripts);
        Task UpdateMigrationRecordsAsync(IEnumerable<MigrationScript> scripts);
        Task AddMigrationAsync(string migrationName, string environmentName, bool isSeed, string? folderPath = null);
        Task GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "DBO");
    }

}
