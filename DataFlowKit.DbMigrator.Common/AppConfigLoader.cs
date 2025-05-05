using DataFlowKit.DbMigrator.Common.Models;
using Microsoft.Extensions.Configuration;

namespace DataFlowKit.DbMigrator.Common
{
    public static class AppConfigLoader
    {
        public static IConfigurationRoot Load(bool isCliProject = false)
        {
            var basePath = ResolveBasePath(isCliProject);
            return new ConfigurationBuilder()
                .SetBasePath(basePath)
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .Build();
        }

        private static string ResolveBasePath(bool isCliProject)
        {
            if (isCliProject)
            {
                return DirectorySearcher.FindStartupProject(CurrentCallInfo.StartupProject);
            }
            if (File.Exists(Path.Combine(Directory.GetCurrentDirectory(), "appsettings.json")))
            {
                return Directory.GetCurrentDirectory();
            }
            throw new FileNotFoundException($"appsettings.json not found at path: {Directory.GetCurrentDirectory()}");
        }
    }

}
