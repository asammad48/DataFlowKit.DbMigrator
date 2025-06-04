// Converted version of SqlServerMigrationProvider.cs for MySQL
using System.Data;
using System.Text.RegularExpressions;
using Dapper;
using DataFlowKit.DbMigrator.Common.Interfaces;
using DataFlowKit.DbMigrator.Common.Models;
using MySql.Data.MySqlClient;

namespace DataFlowKit.DbMigrator.MySql
{
    public class MySqlMigrationProvider : IMigrationProvider
    {
        private readonly string _connectionString;
        public MySqlMigrationProvider(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task EnsureMigrationTableExistsAsync()
        {
            using var connection = new MySqlConnection(_connectionString);
            await connection.OpenAsync();

            var sql = @"
                CREATE TABLE IF NOT EXISTS __MigrationHistory (
                    Id INT AUTO_INCREMENT PRIMARY KEY,
                    FileName VARCHAR(255) NOT NULL,
                    AppliedOn DATETIME NOT NULL,
                    ScriptHash VARCHAR(255) NOT NULL
                )";
            await connection.ExecuteAsync(sql);
        }

        public async Task<List<MigrationHistory>> GetAppliedMigrationsAsync()
        {
            using var connection = new MySqlConnection(_connectionString);
            await connection.OpenAsync();

            var result = await connection.QueryAsync<MigrationHistory>(
                "SELECT FileName, AppliedOn, ScriptHash FROM __MigrationHistory");

            return result.ToList();
        }

        public async Task ValidateScriptsAsync(IEnumerable<MigrationScript> scripts)
        {
            //if (CurrentCallInfo.ScriptName.Equals(RunningScriptType.ValidateScript))
            //{
            //    throw new Exception("MySQL do not support transactions on DDL");
            //}

            var migrationTestDB = $"{DateTime.Now.ToString("yyyyMMddhhmmss")}TestMigration";
            var combinedScript = $"CREATE DATABASE IF NOT EXISTS {migrationTestDB};\r\nUSE {migrationTestDB};";
            foreach (var script in scripts)
            {
                combinedScript += script.Sql + "\r\n";
            }

            combinedScript += $"\r\n DROP DATABASE IF EXISTS {migrationTestDB};";

            using var connection = new MySqlConnection(_connectionString);
            await connection.OpenAsync();
            using var transaction = await connection.BeginTransactionAsync();

            try
            {
                using var command = new MySqlCommand(combinedScript, connection, (MySqlTransaction)transaction);
                await command.ExecuteNonQueryAsync();
                await transaction.RollbackAsync(); // Validate only
            }
            catch (Exception ex)
            {
                using var command = new MySqlCommand($" DROP DATABASE IF EXISTS {migrationTestDB};", connection, (MySqlTransaction)transaction);
                await command.ExecuteNonQueryAsync();
                throw new Exception($"Validation failed: {ex.Message}", ex);
            }
        }

        public async Task ApplyMigrationsAsync(IEnumerable<MigrationScript> scripts)
        {
            using var connection = new MySqlConnection(_connectionString);
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
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                throw new Exception("Migration failed.", ex);
            }
        }

        public async Task UpdateMigrationRecordsAsync(IEnumerable<MigrationScript> scripts)
        {
            using var connection = new MySqlConnection(_connectionString);
            await connection.OpenAsync();

            foreach (var script in scripts)
            {
                await connection.ExecuteAsync(
                    "INSERT INTO __MigrationHistory (FileName, AppliedOn, ScriptHash) VALUES (@FileName, NOW(), @ScriptHash)",
                    new { script.FileName, ScriptHash = script.GitHash });
            }
        }

        public async Task UpdateSingleMigrationRecordsAsync(string fileName, string gitHash)
        {
            using var connection = new MySqlConnection(_connectionString);
            await connection.OpenAsync();

            await connection.ExecuteAsync(
                "INSERT INTO __MigrationHistory (FileName, AppliedOn, ScriptHash) VALUES (@FileName, NOW(), @ScriptHash)",
                new { fileName, ScriptHash = gitHash });
        }

        public async Task AddMigrationAsync(string migrationName, string environmentName, bool isMigrationAlreadyApplied, string? folderPath = null)
        {
            var folder = folderPath ?? "Migrations";
            Directory.CreateDirectory(folder);

            var existingFiles = Directory.GetFiles(folder, "*.sql")
                                         .Select(Path.GetFileNameWithoutExtension)
                                         .Where(f => Regex.IsMatch(f ?? "", @"^\d{8}_"))
                                         .ToList();

            int nextOrder = existingFiles.Any()
                ? existingFiles.Select(f => int.TryParse(f?.Split('_')[0], out var n) ? n : 0).Max() + 1
                : 1;

            var orderPrefix = nextOrder.ToString("D8");
            var safeName = string.Join("_", migrationName.Split(Path.GetInvalidFileNameChars(), StringSplitOptions.RemoveEmptyEntries));
            var fileName = $"{orderPrefix}_{safeName}_{environmentName}.sql";
            var purposeOfFile = isMigrationAlreadyApplied ? "MigrationAlreadyApplied" : "";
            var fullPath = Path.Combine(folder, fileName);
            var sql = $@"/*
============================================================
 File        : {fileName}
 Purpose     : {purposeOfFile}
 Author      : Unknown
 Created On  : {DateTime.Now:yyyy-MM-dd}
 Environment : {environmentName}
============================================================
*/";

            if (!File.Exists(fullPath))
            {
                await File.WriteAllTextAsync(fullPath, sql);
            }
        }

        public async Task GenerateClassesFromStoredProc(GenerateStoredProcedureAnalyser storedProcedureModel)
        {
            new StoredProcAnalyzer(_connectionString).GenerateClassesFromStoredProc(storedProcedureModel.StoredProcedureName, storedProcedureModel.OutputDirectory, storedProcedureModel.NamingConvention, storedProcedureModel.UseNestedModels, storedProcedureModel.GenerateXMLComments);
        }
    }
}
