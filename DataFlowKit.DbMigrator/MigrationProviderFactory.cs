using DataFlowKit.DbMigrator.Common.Interfaces;
using DataFlowKit.DbMigrator.MySql;
//using DataFlowKit.DbMigrator.PostgreSql;
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
               // "postgres" => new PostgreSqlMigrationProvider(connectionString),
                "mysql" => new MySqlMigrationProvider(connectionString),
                _ => throw new NotSupportedException($"Provider '{provider}' is not supported.")
            };
        }


    }
}
