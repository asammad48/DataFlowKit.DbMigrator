using DataFlowKit.DbMigrator.Common.Models;
using Microsoft.Extensions.Configuration;

namespace DataFlowKit.DbMigrator.Common
{
    public class DefaultValueProvider
    {
        private static IConfiguration _configuration;
        private readonly string _connectionString;

        static DefaultValueProvider()
        {
            _configuration = AppConfigLoader.Load(CurrentCallInfo.IsCallFromCLI);
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

        public static string GetMigrationPath(string migrationPath, bool createDirectory = false)
        {
            if (!string.IsNullOrEmpty(migrationPath))
            {
                migrationPath = PathUtils.ResoveOutputDirectoryPath(migrationPath);
                return migrationPath;
            }
            else
            {
                var projectDirectory = Directory.GetCurrentDirectory();
                if (CurrentCallInfo.IsCallFromCLI)
                {
                    var projectName = GetMigrationProjectName();
                    projectDirectory = Path.Combine(Directory.GetCurrentDirectory(), projectName);
                }
                if (Directory.Exists(projectDirectory))
                {
                    var folderName = GetMigrationFolderName();
                    var folderDirectory = Path.Combine(projectDirectory, folderName);
                    if (Directory.Exists(folderDirectory))
                    {
                        return folderDirectory;
                    }
                    if (createDirectory)
                    {
                        Directory.CreateDirectory(folderDirectory);
                        return folderDirectory;
                    }
                    throw new DirectoryNotFoundException($"Migration Directory not found at path {projectDirectory}");
                }
                throw new DirectoryNotFoundException($"Project Directory not found at path {projectDirectory}");
            }
        }

        public static string GetStoredProcedureModelPath(string outputDirectory, bool createDirectory = false)
        {
            if (!string.IsNullOrEmpty(outputDirectory))
            {
                outputDirectory = PathUtils.ResoveOutputDirectoryPath(outputDirectory);
                return outputDirectory;
            }
            else
            {
                CurrentCallInfo.IsEntityDirectoryRelativePath = true;
                var projectName = GetSPProjectName();
                var projectDirectory = Path.Combine(Directory.GetCurrentDirectory(), projectName);
                if (Directory.Exists(projectDirectory))
                {
                    var folderName = GetSPFolderName();
                    var folderDirectory = Path.Combine(projectDirectory, folderName);
                    if (Directory.Exists(folderDirectory))
                    {
                        return folderDirectory;
                    }
                    if (createDirectory)
                    {
                        Directory.CreateDirectory(folderDirectory);
                        return folderDirectory;
                    }
                    throw new DirectoryNotFoundException($"Entity Directory not found at path {projectDirectory}");
                }
                throw new DirectoryNotFoundException($"Project Directory not found at path {projectDirectory}");
            }
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


        public static string GetMigrationProjectName()
        {
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:MigrationProject"]))
            {
                return _configuration["DapperMigrator:MigrationProject"];
            }
            throw new InvalidOperationException("MigrationProject is not defined in configuration settings.");
        }

        public static string GetMigrationFolderName()
        {
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:MigrationDirectory"]))
            {
                return _configuration["DapperMigrator:MigrationDirectory"];
            }
            throw new InvalidOperationException("MigrationDirectory is not defined in configuration settings.");
        }

        public static string GetSpNamingConvention(string namingConvention)
        {
            if (!string.IsNullOrEmpty(namingConvention))
            {
                return namingConvention;
            }
            if (!string.IsNullOrEmpty(_configuration["DapperMigrator:EntityModelNamingConvention"]))
            {
                return _configuration["DapperMigrator:EntityModelNamingConvention"];
            }
            return "DBO";
        }


    }
}
