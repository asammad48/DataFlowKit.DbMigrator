using Dapper;
using DataFlowKit.DbMigrator.Common.Interfaces;
using DataFlowKit.DbMigrator.Common.Models;
using Npgsql;
using System.Data;

namespace DataFlowKit.DbMigrator.PostgreSql.Providers
{
    public class PostgreSqlMigrationProvider : IMigrationProvider
    {
        private string _connectionString = "";
        private readonly string _defaultMigrationFolder = "Migrations";

        public PostgreSqlMigrationProvider(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task EnsureMigrationTableExistsAsync()
        {
            const string createTableSql = @"
        CREATE TABLE IF NOT EXISTS MigrationHistory (
            FileName TEXT PRIMARY KEY,
            AppliedOn TIMESTAMP NOT NULL,
            GitHash TEXT NOT NULL
        );";

            using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();
            await connection.ExecuteAsync(createTableSql);
        }

        public async Task<List<MigrationHistory>> GetAppliedMigrationsAsync()
        {
            const string selectSql = @"SELECT FileName, AppliedOn, GitHash FROM MigrationHistory";

            using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();
            var result = await connection.QueryAsync<MigrationHistory>(selectSql);
            return result.ToList();
        }

        public async Task ValidateScriptsAsync(IEnumerable<MigrationScript> scripts)
        {
            foreach (var script in scripts)
            {
                await ValidateScriptInternalAsync(script.Sql, script.FileName);
            }
        }

        private async Task ValidateScriptInternalAsync(string sql, string fileName)
        {
            using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();

            // Wrap the entire script with NOEXEC + PARSEONLY
            var wrappedSql = $@"
                  BEGIN;
                  {sql}
                  ROLLBACK;
                  ";
            using var command = connection.CreateCommand();
            command.CommandType = CommandType.Text;
            command.CommandText = wrappedSql;

            try
            {
                await command.ExecuteNonQueryAsync();
            }
            catch (Exception ex)
            {
                throw new Exception($"PGSQL Script validation failed in file '{fileName}'.", ex);
            }
        }


        public async Task ApplyMigrationsAsync(IEnumerable<MigrationScript> scripts)
        {
            using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();
            using var transaction = await connection.BeginTransactionAsync();

            try
            {
                foreach (var script in scripts)
                {
                    await connection.ExecuteAsync(script.Sql, transaction: transaction);
                }

                await transaction.CommitAsync();
            }
            catch
            {
                await transaction.RollbackAsync();
                throw;
            }
        }

        public async Task UpdateMigrationRecordsAsync(IEnumerable<MigrationScript> scripts)
        {
            const string insertSql = @"
        INSERT INTO MigrationHistory (FileName, AppliedOn, GitHash)
        VALUES (@FileName, @AppliedOn, @GitHash);";

            using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();

            foreach (var script in scripts)
            {
                await connection.ExecuteAsync(insertSql, new
                {
                    script.FileName,
                    AppliedOn = DateTime.UtcNow,
                    script.GitHash
                });
            }
        }

        public async Task AddMigrationAsync(string migrationName, string environmentName, bool isSeed, string? folderPath = null)
        {
            var folder = folderPath ?? _defaultMigrationFolder;
            Directory.CreateDirectory(folder);

            var timestamp = DateTime.UtcNow.ToString("yyyyMMdd_HHmmss");
            var safeName = string.Join("_", migrationName.Split(Path.GetInvalidFileNameChars()));
            var fileName = $"{timestamp}_{safeName}.sql";
            var fullPath = Path.Combine(folder, fileName);

            if (!File.Exists(fullPath))
            {
                await File.WriteAllTextAsync(fullPath, string.Empty);
            }
        }

        public async Task GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "DBO")
        {

        }
    }


}

