namespace DataFlowKit.DbMigrator.Common
{
    using System;
    using System.IO;

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
                            Console.WriteLine($"Created directory: {targetFolderPath}");
                        }
                        return targetFolderPath;
                    }
                    var parent = Directory.GetParent(searchDirectory);
                    if (parent == null) break;
                    searchDirectory = parent.FullName;
                }
                Console.WriteLine($"Project directory '{projectName}' not found in any parent directory");
                return null;
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error searching/creating directories: {ex.Message}");
                return null;
            }
        }
    }
}
