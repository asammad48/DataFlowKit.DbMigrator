Sure! Here's a clean and concise `README.md` file you can copy and paste directly into your NuGet or GitHub project:

---

````markdown
# 📦 DataFlowKit.DbMigrator.CLI

A simple, extensible .NET CLI tool for managing database migrations and stored procedure models using Dapper.

---

## 🔧 Installation

### Global Installation
```bash
dotnet tool install --global --add-source ./nupkg DataFlowKit.DbMigrator.CLI
````

### Local Installation (project-based)

```bash
dotnet tool install --local DataFlowKit.DbMigrator.CLI --create-manifest-if-needed
```

---

## ❌ Uninstallation

### Global

```bash
dotnet tool uninstall --global DataFlowKit.DbMigrator.CLI
```

### Local

```bash
dotnet tool uninstall --local DataFlowKit.DbMigrator.CLI
```

---

## 🚀 Usage Basics

* The CLI command is accessed using `db-migrator`.
* **Use `dotnet` prefix** when running a locally installed version:

  ```bash
  dotnet db-migrator add-migration ...
  ```
* Run the tool from the **solution folder** (where your `.sln` file exists).

---

## ⚙️ Configuration (Optional)

You can configure default values in your `appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "your_connection_string"
  },
  "DapperMigrator": {
    "EnvironmentName": "QA",
    "ProviderName": "sqlserver",
    "MigrationProject": "YourProject",
    "MigrationDirectory": "Migrations",
    "EntityProject": "YourProject",
    "EntityDirectory": "SpEntity",
    "EntityModelNamingConvention": "DBO"
  }
}
```

If CLI options are not provided explicitly, values will be read from `appsettings.json`.

---

## 🧩 CLI Commands

### ➕ Add Migration

Create an empty SQL migration file.

```bash
db-migrator add-migration --provider sqlserver --environment dev --name "AddUserTable" --output-dir "C:\\Migrations" --startup "YourProject"
```

### ✅ Validate Scripts

Validate pending SQL scripts.

```bash
db-migrator validate-scripts --provider sqlserver --environment dev --output-dir "C:\\Migrations" --startup "YourProject"
```

### ⬆️ Update Database

Validate and run pending scripts on the DB.

```bash
db-migrator update-database --provider sqlserver --environment dev --output-dir "C:\\Migrations" --startup "YourProject"
```

### ❌ Remove Migration

Remove a migration file that hasn't yet been applied.

```bash
db-migrator remove-migration --name "00000001_AddUserTable_dev.sql" --output-dir "C:\\Migrations" --startup "YourProject"
```

### 🔄 Generate SP Models

Generate request/response models for a stored procedure.

```bash
db-migrator sp-model-gen --name "GetUserById" --provider sqlserver --environment dev --output-dir "C:\\SpEntity" --startup "YourProject" --convention "DBO"
```

---

## 🧬 Programmatic Integration

You can also call the migration directly in code (e.g., during startup):

```csharp
UpdateDatabaseProcessor.UpdateDatabase(new UpdateDatabase());
```

Place this after the builder object in your `Program.cs`.

---

## 📋 CLI Command Summary

| Command            | Description                               | CLI Only |
| ------------------ | ----------------------------------------- | -------- |
| `add-migration`    | Create an empty SQL migration file        | ✅        |
| `remove-migration` | Delete a migration file (not yet applied) | ✅        |
| `sp-model-gen`     | Generate SP request/response models       | ✅        |
| `validate-scripts` | Check for unapplied scripts               | ❌        |
| `update-database`  | Apply pending migrations to DB            | ❌        |

---

## 🗂 Notes

* Tool reads settings from `appsettings.json` if options are not passed explicitly.
* Always run the command from the root solution folder.

---

## 🤝 Contributing

Pull requests and feedback are welcome!
