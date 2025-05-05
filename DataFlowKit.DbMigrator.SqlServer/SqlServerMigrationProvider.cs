using Dapper;
using DataFlowKit.DbMigrator.Common.Interfaces;
using DataFlowKit.DbMigrator.Common.Models;
using Microsoft.Data.SqlClient;
using Microsoft.SqlServer.TransactSql.ScriptDom;
using System.Data;
using System.Text.RegularExpressions;

namespace DataFlowKit.DbMigrator.SqlServer
{
    public class SqlServerMigrationProvider : IMigrationProvider
    {
        private readonly string _connectionString;
        public SqlServerMigrationProvider(string connectionString)
        {
            _connectionString = connectionString;
        }
        public async Task EnsureMigrationTableExistsAsync()
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            var sql = @"
                  IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='__MigrationHistory' AND xtype='U')
                  BEGIN
                      CREATE TABLE __MigrationHistory (
                          Id INT IDENTITY(1,1) PRIMARY KEY,
                          FileName NVARCHAR(255) NOT NULL,
                          AppliedOn DATETIME NOT NULL,
                          ScriptHash NVARCHAR(255) NOT NULL
                      )
                  END";
            await connection.ExecuteAsync(sql);
        }

        public async Task<List<MigrationHistory>> GetAppliedMigrationsAsync()
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Getting Applied migrations.");
            var result = await connection.QueryAsync<MigrationHistory>(
                "SELECT FileName, AppliedOn, ScriptHash FROM __MigrationHistory");

            return result.ToList();
        }

        public async Task ValidateScriptsAsync(IEnumerable<MigrationScript> scripts)
        {
            var appendScript = "";
            foreach (var script in scripts)
            {
                appendScript += Environment.NewLine + script.Sql + Environment.NewLine;
                await ValidateScriptInternalAsync(appendScript, script.FileName);
            }


        }
        private async Task ValidateScriptInternalAsync(string sql, string fileName)
        {
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Validating migration file: {fileName}");
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            using var transaction = (SqlTransaction)await connection.BeginTransactionAsync();
            var ddlStatements = SplitIntoBatches(sql, fileName);
            foreach (var ddl in ddlStatements)
            {
                try
                {
                    using var command = connection.CreateCommand();
                    command.CommandType = CommandType.Text;
                    command.CommandText = ddl;
                    command.Transaction = transaction;
                    await command.ExecuteNonQueryAsync();
                }
                catch (SqlException ex)
                {
                    await transaction.RollbackAsync();
                    throw new Exception($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Validation failed in file '{fileName}', ExceptionMessage:{ex.Message}.\nStatement:\n{ddl}", ex);
                }
            }
            await transaction.RollbackAsync();
            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: migration file: {fileName} validated successfully.");
        }



        private List<string> SplitIntoBatches(string sqlScript, string fileName)
        {
            try
            {
                var parser = new TSql150Parser(false); // SQL Server 2019 parser
                IList<ParseError> errors;
                TSqlFragment fragment = parser.Parse(new StringReader(sqlScript), out errors);

                if (errors != null && errors.Count > 0)
                {
                    var error = string.Join("\n", errors);
                    throw new InvalidOperationException($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Validation failed, SQL parsing failed: {error} in file: '{fileName}'");
                }

                var result = new List<string>();
                var generator = new Sql150ScriptGenerator();

                if (fragment is TSqlScript script)
                {
                    foreach (TSqlBatch batch in script.Batches)
                    {
                        generator.GenerateScript(batch, out string batchText);
                        result.Add(batchText.Trim());
                    }
                }

                return result;
            }
            catch (Exception ex)
            {
                throw new Exception($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Validation failed, File parsing failed: '{fileName}'", ex);
            }
        }



        public async Task ApplyMigrationsAsync(IEnumerable<MigrationScript> scripts)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();
            using var transaction = connection.BeginTransaction();

            try
            {
                foreach (var script in scripts)
                {
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration started filename : {script.FileName}.");

                    var ddlStatements = SplitIntoBatches(script.Sql, script.FileName);
                    foreach (var statement in ddlStatements)
                    {
                        await connection.ExecuteAsync(statement, transaction: transaction);
                    }
                    Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration processed filename : {script.FileName}.");
                }

                transaction.Commit();
            }
            catch (Exception ex)
            {
                transaction.Rollback();
                throw new Exception($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration failed. Rollback all migration.", ex);
            }
        }

        public async Task UpdateMigrationRecordsAsync(IEnumerable<MigrationScript> scripts)
        {
            using var connection = new SqlConnection(_connectionString);
            await connection.OpenAsync();

            foreach (var script in scripts)
            {
                await connection.ExecuteAsync(
                    "INSERT INTO __MigrationHistory (FileName, AppliedOn, ScriptHash) VALUES (@FileName, GETDATE(), @ScriptHash)",
                    new { script.FileName, ScriptHash = script.GitHash });
            }
        }

        public async Task AddMigrationAsync(string migrationName, string environmentName, bool isSeed, string? folderPath = null)
        {
            try
            {
                var folder = folderPath;
                Directory.CreateDirectory(folder);

                // Get the next order number
                var existingFiles = Directory.GetFiles(folder, "*.sql")
                                             .Select(Path.GetFileNameWithoutExtension)
                                             .Where(f => Regex.IsMatch(f ?? "", @"^\d{8}_"))
                                             .ToList();

                int nextOrder = 1;

                if (existingFiles.Any())
                {
                    var maxOrder = existingFiles
                        .Select(f => int.TryParse(f?.Split('_')[0], out var n) ? n : 0)
                        .Max();
                    nextOrder = maxOrder + 1;
                }

                var orderPrefix = nextOrder.ToString("D8"); // 8-digit padded number
                var safeName = string.Join("_", migrationName.Split(Path.GetInvalidFileNameChars(), StringSplitOptions.RemoveEmptyEntries));
                var fileName = $"{orderPrefix}_{safeName}_{environmentName}.sql";
                var purposeOfFile = isSeed ? "DML" : "DDL";
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Creating migration file: {fileName}.");
                var fullPath = Path.Combine(folder, fileName);
                string sql = $@"
/*
============================================================
 File        : {fileName}
 Purpose     : {purposeOfFile}
 Author      : Unknown
 Created On  : {DateTime.Now.ToString("yyyy-MM-dd")}
 Environment : {environmentName}
 Usage       : 
 Notes       : 
============================================================
*/
                             ";

                if (!File.Exists(fullPath))
                {
                    await File.WriteAllTextAsync(fullPath, sql);
                }
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Migration file created at location: {fullPath}.");
            }
            catch (Exception ex)
            {
                throw new Exception($"[{DateTime.Now}]  {CurrentCallInfo.ScriptName}: Process failed.", ex);
            }


        }
        public async Task GenerateClassesFromStoredProc(string storedProcName, string outputPath = "", string namingConvention = "DBO")
        {
            new StoredProcAnalyzer(connectionString: _connectionString).GenerateClassesFromStoredProc(storedProcName, outputPath, namingConvention);
        }
    }

}



