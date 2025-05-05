using Microsoft.Extensions.Configuration;
using System.Reflection;

namespace DataFlowKit.DbMigrator.Common
{
    public class DefaultValueProvider
    {
        private static IConfiguration _configuration;
        private readonly string _connectionString;

        static DefaultValueProvider()
        {
            _configuration = AppConfigLoader.Load();
        }

        public static string GetConnectionString(string connectionString)
        {
            return !string.IsNullOrEmpty(connectionString) ? connectionString : _configuration.GetConnectionString("DefaultConnection")
                   ?? throw new InvalidOperationException("DefaultConnection not found in configuration");
        }
        public static string GetEnvironmentName(string environmentName)
        {
            if (!string.IsNullOrEmpty(environmentName))
            {
                return environmentName;
            }
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:EnvironmentName"]))
            {
                return _configuration["DapperMigrator:EnvironmentName"];
            }
            return "All";
        }
        public static string GetProviderName(string providerName)
        {
            if (!string.IsNullOrEmpty(providerName))
            {
                return providerName;
            }
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:ProviderName"]))
            {
                return _configuration["DapperMigrator:ProviderName"];
            }
            return "sqlserver";
        }

        public static string GetMigrationPath(string migrationPath)
        {
            string folderName = "Migrations";
            if (!string.IsNullOrEmpty(migrationPath))
            {
                return migrationPath;
            }
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:MigrationPath"]))
            {
                return _configuration["DapperMigrator:MigrationPath"];
            }
            var currentWorkingDirectory = GetProjectRootPath();
            return Path.Combine(currentWorkingDirectory, folderName);
        }

        public static string GetSPProjectName()
        {
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:EntityProject"]))
            {
                return _configuration["DapperMigrator:EntityProject"];
            }
            throw new InvalidOperationException("EntityProject is not defined in configuration settings.");
        }

        public static string GetSPFolderName()
        {
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:EntityDirectory"]))
            {
                return _configuration["DapperMigrator:EntityDirectory"];
            }
            throw new InvalidOperationException("EntityDirectory is not defined in configuration settings.");
        }
        private static string GetProjectRootPath()
        {
            var assemblyLocation = Assembly.GetExecutingAssembly().Location;
            var directory = new DirectoryInfo(Path.GetDirectoryName(assemblyLocation));
            while (directory != null)
            {
                if (directory.GetFiles("*.csproj").Any() ||
                    directory.GetFiles("*.sln").Any() ||
                    directory.GetDirectories("Migrations").Any())
                {
                    return directory.FullName;
                }
                directory = directory.Parent;
            }
            return Directory.GetCurrentDirectory();
        }
        public static (bool pathExists, string lastFolder) ValidatePathAndGetLastFolder(string path)
        {
            bool exists = Directory.Exists(path) || File.Exists(path);
            string lastFolder = null;

            if (!exists)
            {
                try
                {
                    lastFolder = GetLastFolderInPath(path);
                }
                catch (ArgumentException)
                {
                    lastFolder = "[Invalid Path]";
                }
            }

            return (exists, lastFolder);
        }


        private static string GetLastFolderInPath(string path)
        {
            path = path.Replace(Path.AltDirectorySeparatorChar, Path.DirectorySeparatorChar)
                       .TrimEnd(Path.DirectorySeparatorChar);

            if (Path.GetPathRoot(path) == path)
                return path;

            return Path.GetFileName(path);
        }
    }
}
