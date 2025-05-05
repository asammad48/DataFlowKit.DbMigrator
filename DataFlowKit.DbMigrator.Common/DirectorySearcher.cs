using DataFlowKit.DbMigrator.Common.Models;
using System;
using System.IO;

namespace DataFlowKit.DbMigrator.Common
{
    public class DirectorySearcher
    {
        public static string FindOrCreateProjectFolder(string projectName, string folderName)
        {
            try
            {
                string currentDirectory = Directory.GetCurrentDirectory();
                string searchDirectory = currentDirectory;
                while (!string.IsNullOrEmpty(searchDirectory))
                {
                    string potentialProjectPath = Path.Combine(searchDirectory, projectName);
                    if (Directory.Exists(potentialProjectPath))
                    {
                        string targetFolderPath = Path.Combine(potentialProjectPath, folderName);
                        if (!Directory.Exists(targetFolderPath))
                        {
                            Directory.CreateDirectory(targetFolderPath);
                            Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Created directory: {targetFolderPath}.");
                        }
                        return targetFolderPath;
                    }
                    var parent = Directory.GetParent(searchDirectory);
                    if (parent == null) break;
                    searchDirectory = parent.FullName;
                }
                Console.WriteLine($"[{DateTime.Now}] {CurrentCallInfo.ScriptName}: Project directory '{projectName}' not found in any parent directory.");
                throw new DirectoryNotFoundException($"Directory not found at path {searchDirectory}");
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        public static string FindStartupProject(string projectName)
        {
            try
            {
                string currentDirectory = Directory.GetCurrentDirectory();
                string searchDirectory = currentDirectory;
                while (!string.IsNullOrEmpty(searchDirectory))
                {
                    string potentialProjectPath = Path.Combine(searchDirectory, projectName);
                    if (Directory.Exists(potentialProjectPath))
                    {
                        if (File.Exists(Path.Combine(potentialProjectPath, "appsettings.json")))
                        {
                            return potentialProjectPath;
                        }
                        throw new FileNotFoundException($"appsettings.json not found at path: {potentialProjectPath}");
                    }
                    throw new DirectoryNotFoundException($"StartupProject not found at path {searchDirectory}");
                }
                throw new DirectoryNotFoundException($"StartupProject not found at path {searchDirectory}");
            }
            catch (Exception ex)
            {
                throw;
            }
        }
    }
}
