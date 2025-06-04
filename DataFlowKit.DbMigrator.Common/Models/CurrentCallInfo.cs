namespace DataFlowKit.DbMigrator.Common.Models
{
    public static class CurrentCallInfo
    {
        public static string ScriptName = "";
        public static bool IsCallFromCLI = false;
        public static string StartupProject = "";
        public static bool IsEntityDirectoryRelativePath = false;
    }

    public static class RunningScriptType
    {
        public const string AddMigration = "Add-Migration";
        public const string ValidateScript = "Validate-Script";
        public const string UpdateDatabase = "Update-Database";
        public const string GenerateStoredProcedureModel = "sp-model-gen";
        public const string MarkMigrationAsApplied = "Mark-Migration-As-Applied";
        public const string ImportStoredProcedure = "import-sp";
    }


}
