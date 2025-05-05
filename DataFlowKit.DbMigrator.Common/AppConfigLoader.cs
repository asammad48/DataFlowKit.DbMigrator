using Microsoft.Extensions.Configuration;
using System.Reflection;

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
            //// Stage 1: Check current directory first (works for published apps and debug)
            //var currentDir = Directory.GetCurrentDirectory();
            //if (File.Exists(Path.Combine(currentDir, "appsettings.json")))
            //{
            //    return currentDir;
            //}

            //// Stage 2: For CLI context, try MSBuild (only if needed)
            //if (isCliProject)
            //{
            //    try
            //    {
            //        // Load MSBuild assemblies explicitly with binding redirect
            //        AppDomain.CurrentDomain.AssemblyResolve += CurrentDomain_AssemblyResolve;

            //        var projectPath = Microsoft.Build.Evaluation.ProjectCollection.GlobalProjectCollection
            //            .LoadedProjects.FirstOrDefault()?.FullPath;

            //        if (projectPath != null)
            //        {
            //            var projectDir1 = Path.GetDirectoryName(projectPath);
            //            if (File.Exists(Path.Combine(projectDir1, "appsettings.json")))
            //            {
            //                return projectDir1;
            //            }
            //        }
            //    }
            //    catch
            //    {
            //        // Continue if MSBuild fails
            //    }
            //    finally
            //    {
            //        AppDomain.CurrentDomain.AssemblyResolve -= CurrentDomain_AssemblyResolve;
            //    }
            //}

            //// Stage 3: Assembly-based traversal
            //var assemblyDir = Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location);
            //var projectDir = TraverseUpForProjectDir(assemblyDir);
            //if (projectDir != null && File.Exists(Path.Combine(projectDir, "appsettings.json")))
            //{
            //    return projectDir;
            //}

            //throw new FileNotFoundException("Could not locate appsettings.json in any standard location");
            return "";
        }

        private static Assembly CurrentDomain_AssemblyResolve(object sender, ResolveEventArgs args)
        {
            if (args.Name.StartsWith("Microsoft.Build"))
            {
                // Load the version we actually have
                return Assembly.Load("Microsoft.Build, Version=15.1.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a");
            }
            return null;
        }

        private static string TraverseUpForProjectDir(string startDir)
        {
            var dir = new DirectoryInfo(startDir);
            while (dir != null && !dir.GetFiles("*.csproj").Any())
            {
                dir = dir.Parent;
            }
            return dir?.FullName;
        }
    }

}
