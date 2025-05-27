using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace DataFlowKit.DbMigrator.Common.Models
{
    public class GenerateStoredProcedureAnalyser
    {
        public string StoredProcedureName { get; set; } = "";
        public string OutputDirectory { get; set; } = "";
        public string NamingConvention { get; set; } = "DBO";
        public bool UseNestedModels { get; set; } = false;
        public bool GenerateXMLComments { get; set; } = false;
    }
}
