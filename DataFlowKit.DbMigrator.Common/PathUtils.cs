namespace DataFlowKit.DbMigrator.Common
{
    public static class PathUtils
    {
        private static bool IsAbsolutePath(string path)
        {
            if (string.IsNullOrWhiteSpace(path))
                return false;

            return Path.IsPathRooted(path) && !string.IsNullOrEmpty(Path.GetPathRoot(path)?.Trim('\\', '/'));
        }

        public static string ResoveOutputDirectoryPath(string outputDirectory)
        {
            if (!string.IsNullOrWhiteSpace(outputDirectory))
            {
                if (IsAbsolutePath(outputDirectory))
                {
                    return outputDirectory;
                }
                else
                {
                    return Path.Combine(Directory.GetCurrentDirectory(), outputDirectory);
                }
            }
            return "";

        }
    }

}
