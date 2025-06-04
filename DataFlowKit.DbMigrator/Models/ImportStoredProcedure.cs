using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataFlowKit.DbMigrator.Models
{
    public class ImportStoredProcedure
    {
        public string Environment { get; set; } = "";
        public string Provider { get; set; } = "";
        public string StartupProject { get; set; } = "";
        public string ProcedureName { get; set; } = "";
        public string ConnectionString { get; set; } = "";
        public string MigrationName { get; set; } = "";
        public string MigrationPath { get; set; } = "";
    }
}
