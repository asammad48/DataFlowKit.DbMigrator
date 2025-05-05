using DataFlowKit.DbMigrator.Common.Interfaces;
using DataFlowKit.DbMigrator.PostgreSql.Providers;
using DataFlowKit.DbMigrator.SqlServer;

namespace DataFlowKit.DbMigrator
{
    public static class MigrationProviderFactory
    {
        public static IMigrationProvider Create(string provider, string connectionString)
        {
            return provider.ToLower() switch
            {
                "sqlserver" => new SqlServerMigrationProvider(connectionString),
                "postgres" => new PostgreSqlMigrationProvider(connectionString),
                _ => throw new NotSupportedException($"Provider '{provider}' is not supported.")
            };
        }


    }
}
