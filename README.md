# **DataFlowKit Database Migrator** 🚀  

---

## **Overview** 📖  
**DataFlowKit.DbMigrator** is a flexible database migration tool that supports:  
✔ **SQL Server & PostgreSQL**  
✔ **Environment-based migrations** (QA/Test/Prod)  
✔ **CLI & Programmatic execution**  
✔ **Stored Procedure Model Generation**  

---

## **Installation** ⚙️  

### **CLI Tool Installation**  
#### **1. Global Installation (Recommended for Dev Machines)**  
```sh
dotnet tool install --global --add-source ./nupkg DataFlowKit.DbMigrator.CLI
```  

#### **2. Local Installation (Project-Specific)**  
```sh
dotnet tool install --local DataFlowKit.DbMigrator.CLI --create-manifest-if-needed
```  

#### **Uninstallation**  
```sh
# Global
dotnet tool uninstall --global DataFlowKit.DbMigrator.CLI

# Local
dotnet tool uninstall --local DataFlowKit.DbMigrator.CLI
```  

### **NuGet Package (Programmatic Approach)**  
If you want to integrate migrations **inside your application** (not CLI-based), install:  
```sh
dotnet add package DataFlowKit.DbMigrator
```  

---

## **Configuration** ⚙️  

### **Connection Strings** 🔗  
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=.;Database=MyDb;Trusted_Connection=True;Encrypt=True;TrustServerCertificate=True;"
  }
}
```  
- **Fallback:** If `--connection` is not provided in CLI, it uses `DefaultConnection`.  

### **Migration Settings** 📂  
```json
{
  "DapperMigrator": {
    "EnvironmentName": "QA",  // Default: "All"
    "ProviderName": "sqlserver",  // "sqlserver" or "postgresql"
    "MigrationProject": "MyApp.Data",
    "MigrationDirectory": "Migrations",
    "EntityProject": "MyApp.Data",
    "EntityDirectory": "SpEntities",
    "EntityModelNamingConvention": "DBO"  // Appended to SP models
  }
}
```  

| Setting | CLI Parameter | Default |
|---------|--------------|---------|
| `EnvironmentName` | `--environment` | `All` |
| `ProviderName` | `--provider` | `sqlserver` |
| `Migration Path` | `--output-dir` | `MigrationProject + MigrationDirectory` |
| `SP Entity Path` | `--output-dir` | `EntityProject + EntityDirectory` |

---

## **CLI Commands** 💻  

### **`add-migration`** ✨  
**Creates a new migration file.**  
```sh
dotnet db-migrator add-migration \
  --name "CreateUserTable" \
  --startup "MyApp.Data" \
  [--provider sqlserver|postgresql] \
  [--environment QA|Test|Prod] \
  [--output-dir "Custom/Migrations/Path"]
```

| Parameter        | Required? | Default Value           | Description |
|-----------------|-----------|-------------------------|-------------|
| `--name`        | ✅ Yes    | *(None)*                | Migration name (e.g., `"AddUserTable"`) |
| `--startup`     | ✅ Yes    | *(None)*                | Startup project (where `appsettings.json` lives) |
| `--provider`    | ❌ Optional | `sqlserver` (from config) | Database provider (`sqlserver`/`postgresql`) |
| `--environment` | ❌ Optional | `All` (from config)     | Target environment (`QA`/`Test`/`Prod`) |
| `--output-dir`  | ❌ Optional | `MigrationProject + MigrationDirectory` (from config) | Custom path for migration files |

**Example:**  
```sh
dotnet db-migrator add-migration --name "AddUserTable" --startup "MyApp.Data"
```

📌 **Output:** `{Timestamp}_{Name}_{Environment}.sql` (e.g., `00000001_CreateUserTable_QA.sql`)  

---

### **`validate-scripts`** 🔍  
**Checks pending migrations not yet applied.**  
```sh
dotnet db-migrator validate-scripts \
  --startup "MyApp.Data" \
  [--provider sqlserver|postgresql] \
  [--environment QA|Test|Prod] \
  [--connection "Server=..."]  # Overrides appsettings.json
```  
| Parameter        | Required? | Default Value           | Description |
|-----------------|-----------|-------------------------|-------------|
| `--startup`     | ✅ Yes    | *(None)*                | Startup project |
| `--provider`    | ❌ Optional | `sqlserver` (from config) | Database provider |
| `--environment` | ❌ Optional | `All` (from config)     | Target environment |
| `--connection`  | ❌ Optional | `DefaultConnection` (from config) | Custom connection string |
| `--output-dir`  | ❌ Optional | `MigrationProject + MigrationDirectory` (from config) | Custom migrations path |

**Example:**  
```sh
dotnet db-migrator validate-scripts --startup "MyApp.Data"
```
---

### **`update-database`** 🚀  
**Applies pending migrations to the database.**  
```sh
dotnet db-migrator update-database \
  --startup "MyApp.Data" \
  [--provider sqlserver|postgresql] \
  [--environment QA|Test|Prod]
```  
| Parameter        | Required? | Default Value           | Description |
|-----------------|-----------|-------------------------|-------------|
| `--startup`     | ✅ Yes    | *(None)*                | Startup project |
| `--provider`    | ❌ Optional | `sqlserver` (from config) | Database provider |
| `--environment` | ❌ Optional | `All` (from config)     | Target environment |
| `--connection`  | ❌ Optional | `DefaultConnection` (from config) | Custom connection string |

**Example:**  
```sh
dotnet db-migrator update-database --startup "MyApp.Data" --environment Prod
```
---

### **`remove-migration`** 🗑️  
**Deletes a migration file (if not applied to DB).**  
```sh
dotnet db-migrator remove-migration \
  --name "00000001_CreateUserTable_QA.sql" \
  --startup "MyApp.Data"
```  
| Parameter        | Required? | Default Value           | Description |
|-----------------|-----------|-------------------------|-------------|
| `--name`        | ✅ Yes    | *(None)*                | Exact migration filename (e.g., `"00000001_AddUserTable_QA.sql"`) |
| `--startup`     | ✅ Yes    | *(None)*                | Startup project |
| `--output-dir`  | ❌ Optional | `MigrationProject + MigrationDirectory` (from config) | Custom migrations path |

**Example:**  
```sh
dotnet db-migrator remove-migration --name "00000001_AddUserTable_QA.sql" --startup "MyApp.Data"
```
---

### **`sp-model-gen`** 📄  
**Generates C# models for Stored Procedures.**  
```sh
dotnet db-migrator sp-model-gen \
  --name "GetUserById" \
  --startup "MyApp.Data" \
  [--convention "DBO"]  # Model suffix (default: "DBO")
```
| Parameter        | Required? | Default Value           | Description |
|-----------------|-----------|-------------------------|-------------|
| `--name`        | ✅ Yes    | *(None)*                | Stored procedure name (e.g., `"GetUserById"`) |
| `--startup`     | ✅ Yes    | *(None)*                | Startup project |
| `--provider`    | ❌ Optional | `sqlserver` (from config) | Database provider |
| `--environment` | ❌ Optional | `All` (from config)     | Target environment |
| `--convention`  | ❌ Optional | `DBO` (from config)     | Model naming suffix (e.g., `Request_DBO.cs`) |
| `--output-dir`  | ❌ Optional | `EntityProject + EntityDirectory` (from config) | Custom path for SP models |

**Example:**  
```sh
dotnet db-migrator sp-model-gen --name "GetUserById" --startup "MyApp.Data"
```
📌 **Output:**  
- `GetUserByIdRequest_DBO.cs`  
- `GetUserByIdResponse_DBO.cs`  

---

## **Programmatic Usage** 🔧  

### **Update Database Programmatically**  
```csharp
using DataFlowKit.DbMigrator;

// In Program.cs (ASP.NET Core)
var builder = WebApplication.CreateBuilder(args);
UpdateDatabaseProcessor.UpdateDatabase(new UpdateDatabase());
```  

### **Validate Scripts Programmatically**  
```csharp
var validationResult = UpdateDatabaseProcessor.ValidateScripts(new ValidateScripts());
if (!validationResult.IsValid)
{
    Console.WriteLine("Pending migrations exist!");
}
```  

---

## **Best Practices** ✅  

1. **Commit migration files** to version control.  
2. **Avoid manual DB edits**—always use migrations.  
3. **For CI/CD**, use CLI commands in build pipelines.  
4. **For SP models**, update them when SP schema changes.  

---

## **FAQ** ❓  

**Q: Can I use both CLI and programmatic approaches?**  
✅ **Yes!** CLI is for dev-time, programmatic for runtime.  

**Q: What if I change a migration after applying it?**  
⚠️ **Never modify applied migrations.** Create a new one instead.  

**Q: How to handle multiple environments?**  
🔧 Use `--environment` in CLI or declare envionment variable in appsettings `Environment`.  

**Q: Will My Migrations Be Included in the Build Output?**  
❌ No, your migration files will not automatically be included in the build output. You must explicitly configure your .csproj file to include them.  
```xml
<ItemGroup>
    <Content Include="Migrations\**">
        <CopyToOutputDirectory>PreserveNewest</CopyToOutputDirectory>
    </Content>
</ItemGroup>
```  
---
