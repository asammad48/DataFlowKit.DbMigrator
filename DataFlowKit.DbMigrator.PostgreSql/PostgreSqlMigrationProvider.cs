//using Dapper;
//using DataFlowKit.DbMigrator.Common.Interfaces;
//using DataFlowKit.DbMigrator.Common.Models;
//using Npgsql;
//using System.Data;
//using System.Text.RegularExpressions;

//namespace DataFlowKit.DbMigrator.PostgreSql.Providers
//{
//    public class PostgreSqlMigrationProvider : IMigrationProvider
//    {
//        private string _connectionString = "";
//        private readonly string _defaultMigrationFolder = "Migrations";

//        public PostgreSqlMigrationProvider(string connectionString)
//        {
//            _connectionString = connectionString;
//        }

//        public async Task EnsureMigrationTableExistsAsync()
//        {
//            const string createTableSql = @"
//        CREATE TABLE IF NOT EXISTS MigrationHistory (
//            FileName TEXT PRIMARY KEY,
//            AppliedOn TIMESTAMP NOT NULL,
//            GitHash TEXT NOT NULL
//        );";

//            using var connection = new NpgsqlConnection(_connectionString);
//            await connection.OpenAsync();
//            await connection.ExecuteAsync(createTableSql);
//        }

//        public async Task<List<MigrationHistory>> GetAppliedMigrationsAsync()
//        {
//            const string selectSql = @"SELECT FileName, AppliedOn, GitHash FROM MigrationHistory";

//            using var connection = new NpgsqlConnection(_connectionString);
//            await connection.OpenAsync();
//            var result = await connection.QueryAsync<MigrationHistory>(selectSql);
//            return result.ToList();
//        }

//        public async Task ValidateScriptsAsync(IEnumerable<MigrationScript> scripts)
//        {
//            foreach (var script in scripts)
//            {
//                await ValidateScriptInternalAsync(script.Sql, script.FileName);
//            }
//        }

//        private async Task ValidateScriptInternalAsync(string sql, string fileName)
//        {
//            using var connection = new NpgsqlConnection(_connectionString);
//            await connection.OpenAsync();

//            // Wrap the entire script with NOEXEC + PARSEONLY
//            var wrappedSql = $@"
//                  BEGIN;
//                  {sql}
//                  ROLLBACK;
//                  ";
//            using var command = connection.CreateCommand();
//            command.CommandType = CommandType.Text;
//            command.CommandText = wrappedSql;

//            try
//            {
//                await command.ExecuteNonQueryAsync();
//            }
//            catch (Exception ex)
//            {
//                throw new Exception($"PGSQL Script validation failed in file '{fileName}'.", ex);
//            }
//        }


//        public async Task ApplyMigrationsAsync(IEnumerable<MigrationScript> scripts)
//        {
//            using var connection = new NpgsqlConnection(_connectionString);
//            await connection.OpenAsync();
//            using var transaction = await connection.BeginTransactionAsync();

//            try
//            {
//                foreach (var script in scripts)
//                {
//                    await connection.ExecuteAsync(script.Sql, transaction: transaction);
//                }

//                await transaction.CommitAsync();
//            }
//            catch
//            {
//                await transaction.RollbackAsync();
//                throw;
//            }
//        }

//        public async Task UpdateMigrationRecordsAsync(IEnumerable<MigrationScript> scripts)
//        {
//            const string insertSql = @"
//        INSERT INTO MigrationHistory (FileName, AppliedOn, GitHash)
//        VALUES (@FileName, @AppliedOn, @GitHash);";

//            using var connection = new NpgsqlConnection(_connectionString);
//            await connection.OpenAsync();

//            foreach (var script in scripts)
//            {
//                await connection.ExecuteAsync(insertSql, new
//                {
//                    script.FileName,
//                    AppliedOn = DateTime.UtcNow,
//                    script.GitHash
//                });
//            }
//        }

//        public async Task AddMigrationAsync(string migrationName, string environmentName, bool isSeed, string? folderPath = null)
//        {
//            var folder = folderPath ?? _defaultMigrationFolder;
//            Directory.CreateDirectory(folder);

//            var timestamp = DateTime.UtcNow.ToString("yyyyMMdd_HHmmss");
//            var safeName = string.Join("_", migrationName.Split(Path.GetInvalidFileNameChars()));
//            var fileName = $"{timestamp}_{safeName}.sql";
//            var fullPath = Path.Combine(folder, fileName);

//            if (!File.Exists(fullPath))
//            {
//                await File.WriteAllTextAsync(fullPath, string.Empty);
//            }
//        }

//        public async Task GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "DBO")
//        {

//        }

//        public async Task UpdateSingleMigrationRecordsAsync(string fileName, string gitHash)
//        {

//        }
//    }
//}

using Dapper;
using DataFlowKit.DbMigrator.Common.Interfaces;
using DataFlowKit.DbMigrator.Common.Models;
using Npgsql;
using System.Data;
using System.Text.RegularExpressions;

namespace DataFlowKit.DbMigrator.PostgreSql
{
    public class PostgreSqlMigrationProvider : IMigrationProvider
    {
        private readonly string _connectionString;

        public PostgreSqlMigrationProvider(string connectionString)
        {
            _connectionString = connectionString;
        }

        public async Task EnsureMigrationTableExistsAsync()
        {
            await using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();

            var sql = @"
                CREATE TABLE IF NOT EXISTS ""__MigrationHistory"" (
                    ""Id"" SERIAL PRIMARY KEY,
                    ""FileName"" VARCHAR(255) NOT NULL,
                    ""AppliedOn"" TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
                    ""ScriptHash"" VARCHAR(255) NOT NULL
                );
            ";

            await connection.ExecuteAsync(sql);
        }

        public async Task<List<MigrationHistory>> GetAppliedMigrationsAsync()
        {
            await using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();

            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Getting applied migrations.");

            var result = await connection.QueryAsync<MigrationHistory>(
                @"SELECT ""FileName"", ""AppliedOn"", ""ScriptHash"" FROM ""__MigrationHistory""");

            return result.ToList();
        }

        public async Task ValidateScriptsAsync(IEnumerable<MigrationScript> scripts)
        {
            var combinedScript = "";
            foreach (var script in scripts)
            {
                combinedScript += Environment.NewLine + script.Sql + Environment.NewLine;
                await ValidateScriptInternalAsync(combinedScript, script.FileName);
            }
        }

        private async Task ValidateScriptInternalAsync(string sql, string fileName)
        {
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Validating migration file: {fileName}");

            await using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();
            await using var transaction = await connection.BeginTransactionAsync();

            try
            {
                var statements = sql.Split(";", StringSplitOptions.RemoveEmptyEntries);
                foreach (var statement in statements)
                {
                    await connection.ExecuteAsync(statement, transaction: transaction);
                }

                await transaction.RollbackAsync();
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: migration file: {fileName} validated successfully.");
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                throw new Exception($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Validation failed in file '{fileName}', Message: {ex.Message}", ex);
            }
        }

        public async Task ApplyMigrationsAsync(IEnumerable<MigrationScript> scripts)
        {
            await using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();
            await using var transaction = await connection.BeginTransactionAsync();

            try
            {
                foreach (var script in scripts)
                {
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Applying migration: {script.FileName}");

                    var statements = script.Sql.Split(";", StringSplitOptions.RemoveEmptyEntries);
                    foreach (var stmt in statements)
                    {
                        await connection.ExecuteAsync(stmt, transaction: transaction);
                    }

                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Applied migration: {script.FileName}");
                }

                await transaction.CommitAsync();
            }
            catch (Exception ex)
            {
                await transaction.RollbackAsync();
                throw new Exception($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration failed. Rollback initiated.", ex);
            }
        }

        public async Task UpdateMigrationRecordsAsync(IEnumerable<MigrationScript> scripts)
        {
            await using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();

            foreach (var script in scripts)
            {
                await connection.ExecuteAsync(
                    @"INSERT INTO ""__MigrationHistory"" (""FileName"", ""AppliedOn"", ""ScriptHash"")
                      VALUES (@FileName, CURRENT_TIMESTAMP, @ScriptHash)",
                    new { script.FileName, ScriptHash = script.GitHash });
            }
        }

        public async Task UpdateSingleMigrationRecordsAsync(string fileName, string gitHash)
        {
            await using var connection = new NpgsqlConnection(_connectionString);
            await connection.OpenAsync();

            await connection.ExecuteAsync(
                @"INSERT INTO ""__MigrationHistory"" (""FileName"", ""AppliedOn"", ""ScriptHash"")
                  VALUES (@FileName, CURRENT_TIMESTAMP, @ScriptHash)",
                new { fileName, ScriptHash = gitHash });
        }

        public async Task AddMigrationAsync(string migrationName, string environmentName, bool isSeed, string? folderPath = null)
        {
            try
            {
                var folder = folderPath ?? Directory.GetCurrentDirectory();
                Directory.CreateDirectory(folder);

                var existingFiles = Directory.GetFiles(folder, "*.sql")
                                             .Select(Path.GetFileNameWithoutExtension)
                                             .Where(f => Regex.IsMatch(f ?? "", @"^\d{8}_"))
                                             .ToList();

                int nextOrder = 1;
                if (existingFiles.Any())
                {
                    nextOrder = existingFiles
                        .Select(f => int.TryParse(f?.Split('_')[0], out var n) ? n : 0)
                        .Max() + 1;
                }

                var orderPrefix = nextOrder.ToString("D8");
                var safeName = string.Join("_", migrationName.Split(Path.GetInvalidFileNameChars(), StringSplitOptions.RemoveEmptyEntries));
                var fileName = $"{orderPrefix}_{safeName}_{environmentName}.sql";
                var purpose = isSeed ? "DML" : "DDL";

                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Creating migration file: {fileName}.");

                var fullPath = Path.Combine(folder, fileName);
                var sqlTemplate = $@"
/*
============================================================
 File        : {fileName}
 Purpose     : {purpose}
 Author      : Unknown
 Created On  : {DateTime.Now:yyyy-MM-dd}
 Environment : {environmentName}
 Usage       : 
 Notes       : 
============================================================
*/
";

                if (!File.Exists(fullPath))
                {
                    await File.WriteAllTextAsync(fullPath, sqlTemplate);
                }

                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration file created at location: {fullPath}.");
            }
            catch (Exception ex)
            {
                throw new Exception($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Failed to create migration.", ex);
            }
        }

        public async Task GenerateClassesFromStoredProc(GenerateStoredProcedureAnalyser storedProcedureModel)
        {
            new StoredProcAnalyzer(connectionString: _connectionString)
                .GenerateClassesFromStoredProc(storedProcedureModel.StoredProcedureName, storedProcedureModel.OutputDirectory, storedProcedureModel.NamingConvention, storedProcedureModel.UseNestedModels, storedProcedureModel.GenerateXMLComments);
        }
    }
}
