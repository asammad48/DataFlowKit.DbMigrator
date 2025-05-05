using DataFlowKit.DbMigrator.Common.Models;

namespace DataFlowKit.DbMigrator.Common
{
    public static class ScriptLoader
    {
        public static List<MigrationScript> LoadScripts(string migrationPath)
        {
            try
            {
                var scripts = new List<MigrationScript>();
                var files = Directory.GetFiles(migrationPath, "*.sql", SearchOption.AllDirectories);
                if (files == null || files.Count() == 0)
                {
                    throw new InvalidOperationException($"No file found in the migration folder : '{migrationPath}'.");
                }
                foreach (var file in files)
                {
                    var sql = File.ReadAllText(file);
                    var fileName = Path.GetFileName(file);

                    var environments = ExtractEnvironments(fileName);
                    var isSeed = fileName.Contains("Seed", StringComparison.OrdinalIgnoreCase);
                    var gitHash = GetGitCommitHash(file);

                    scripts.Add(new MigrationScript
                    {
                        FileName = fileName,
                        Sql = sql,
                        IsSeed = isSeed,
                        Environments = environments,
                        GitHash = gitHash
                    });
                }

                return scripts;
            }
            catch (FileNotFoundException ex)
            {
                throw new InvalidOperationException($"File not found: {ex.FileName}");
            }
            catch (DirectoryNotFoundException ex)
            {
                throw new InvalidOperationException($"Directory not found: {ex.Message}");
            }
            catch (IOException ex)
            {
                throw new InvalidOperationException($"IO error: {ex.Message}");
            }

        }

        public static void ValidateScripts(string migrationPath)
        {
            var scripts = Directory.GetFiles(migrationPath, "*.sql", SearchOption.AllDirectories);

            foreach (var file in scripts)
            {
                var sql = File.ReadAllText(file);
            }
        }

        private static List<string> ExtractEnvironments(string sql)
        {
            var nameWithoutExtension = Path.GetFileNameWithoutExtension(sql);
            var parts = nameWithoutExtension.Split('_');
            if (parts.Length >= 3)
            {
                return new List<string> { parts[^1] };
            }
            return new List<string> { "All" };
        }

        private static string GetGitCommitHash(string filePath)
        {
            var directory = Path.GetDirectoryName(filePath);
            var processInfo = new System.Diagnostics.ProcessStartInfo("git", $"log -n 1 --pretty=format:\"%H\" -- \"{filePath}\"")
            {
                WorkingDirectory = directory,
                RedirectStandardOutput = true,
                UseShellExecute = false,
                CreateNoWindow = true
            };

            var process = System.Diagnostics.Process.Start(processInfo);
            process.WaitForExit();
            return process.StandardOutput.ReadToEnd().Trim();
        }
    }
}
