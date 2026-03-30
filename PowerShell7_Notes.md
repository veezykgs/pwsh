# PowerShell 7 — Study Notes

> Quick-reference notes from our sessions. Use for revision.

---

## PowerShell 5.1 vs 7 — Key Differences

- **Runtime:** 5.1 = .NET Framework (Windows only), 7 = .NET Core (cross-platform)
- **Executables:** 5.1 = `powershell.exe`, 7 = `pwsh.exe` (can coexist)
- **Development:** 5.1 is maintenance-only; 7 is open source and actively updated
- **Language additions in 7:** ternary (`? :`), null-coalescing (`??`), pipeline chains (`&&` `||`), `ForEach-Object -Parallel`
- **Remoting:** 7 supports SSH remoting in addition to WinRM
- **Encoding:** 7 defaults to UTF-8 everywhere; 5.1 used mixed encodings
- **Error handling:** 7 has `Get-Error` and `ConciseView` for cleaner error output
- **Styling:** 7 has `$PSStyle` for ANSI terminal colors
- **Compatibility:** Some legacy Windows modules only work in 5.1; use `Import-Module -UseWindowsPowerShell` as a bridge

**Try it:**
```powershell
# See the difference — run in each shell
powershell.exe -c '$PSVersionTable'   # 5.1
pwsh.exe -c '$PSVersionTable'         # 7
```

---

## The Help System — Discovery Trinity

### `Get-Help` — what does a command do?
- `Get-Help <cmd>` — basic, `Get-Help <cmd> -Detailed`, `-Full`, `-Examples`, `-Online`
- Run `Update-Help` (as admin) first to download local help files
- Wildcards: `Get-Help *process*`
- Conceptual topics: `Get-Help about_Operators`, `Get-Help about_*`

### `Get-Command` — find commands
- `Get-Command -Verb Get` / `-Noun Process` / `-Module <name>` / `-Type Cmdlet`
- Wildcards: `Get-Command *firewall*`
- `Get-Verb` — list all approved verbs (PowerShell uses Verb-Noun naming)

### `Get-Member` — what properties/methods does an object have?
- `Get-Process | Get-Member` — see all members
- `-MemberType Property` or `-MemberType Method` to filter
- Shorthand: `gm`
- This is how you discover what `Select-Object` can pick from

**Try it:**
```powershell
# Full discovery flow: find a command, learn it, explore its output
Get-Command *service*                              # 1. find commands
Get-Help Get-Service -Examples                     # 2. see usage
Get-Service | Get-Member                           # 3. what properties exist?
Get-Service | Select-Object Name, Status, StartType  # 4. pick what you need
```

### Discovery pattern
1. `Get-Command *keyword*` — find the command
2. `Get-Help Command -Examples` — learn usage
3. `Command | Get-Member` — explore the output object
4. `Select-Object` the properties you need

### Extras
- `(Get-Command <cmd>).Parameters.Keys` — quick param list
- `Show-Command <cmd>` — opens a GUI form for any command

---

## Filesystem Navigation

### Moving around
- `Get-Location` (alias `pwd`) — current directory
- `Set-Location <path>` (alias `cd`) — change directory, `..` for up, `~` for home
- `Push-Location` / `Pop-Location` — bookmark and jump back

### Listing contents — `Get-ChildItem` (alias `ls`, `dir`)
- `-File` / `-Directory` — filter to files or folders only
- `-Recurse` — go into subfolders
- `-Filter *.ps1` — fast wildcard filter (provider-level, faster than `-Include`)
- `-Hidden` — include hidden items

### Inspect a single item — `Get-Item`
- `(Get-Item file.txt).Length` — size in bytes
- `(Get-Item folder).LastWriteTime` — last modified

### Create / Copy / Move / Delete
- `New-Item -Path <path> -ItemType File` or `Directory`
- `Copy-Item src dest` | `Move-Item src dest` | `Remove-Item target`
- `Remove-Item folder -Recurse` to delete folder with contents

### Existence check — `Test-Path`
- Returns `$true` / `$false` — use in `if` blocks

**Try it:**
```powershell
# List all .ps1 files in C:\Scripts, sorted by size
Get-ChildItem C:\Scripts -Filter *.ps1 -Recurse | Sort-Object Length -Descending | Select-Object Name, Length
```

---

## Variables

### Basics
- Variable names start with `$` and do not need a type by default
- Assign with `=` and reassign anytime
- PowerShell variables are objects, not plain text only

### Common variable types
- String: `$name = "Sam"`
- Int: `$count = 3`
- Array: `$items = "a", "b", "c"`
- Hashtable: `$config = @{ Env = "Dev"; Retries = 2 }`
- DateTime: `$now = Get-Date`

### Interpolation and subexpressions
- Double quotes expand variables: `"Hello $name"`
- Single quotes are literal: `'Hello $name'`
- Use `$()` when embedding expressions: `"Next year: $((Get-Date).Year + 1)"`

### Scope quick view
- Local scope is default inside your current script/function
- Script scope: `$script:varName`
- Global scope: `$global:varName` (use carefully)

### Automatic variables to know
- `$PSVersionTable` current PowerShell info
- `$_` current pipeline object
- `$null` no value
- `$LASTEXITCODE` exit code from native commands
- `$?` success status of last command

### Good habits
- Use clear names: `$userName`, `$logPath`
- Prefer `$null -eq $var` style null checks in conditionals
- Keep constants read-only when needed:
	`Set-Variable -Name ApiBase -Value "https://example" -Option ReadOnly`

**Try it:**
```powershell
# Create variables, inspect type, and use interpolation
$name = "Alex"
$count = 5
$services = Get-Service | Select-Object -First 3

"User: $name"
"Count type: $($count.GetType().Name)"
$services | Select-Object Name, Status
```

---

## Pipeline Objects, `$null`, and Hashtables

### Pipeline objects: what they are
- PowerShell passes full objects through the pipeline, not plain text lines
- Each command receives objects, can filter/shape them, then passes objects on
- Use `Get-Member` to discover properties and methods on pipeline output

### When to use pipeline objects
- Filtering: `Where-Object`
- Picking properties: `Select-Object`
- Sorting/grouping: `Sort-Object`, `Group-Object`
- Bulk actions: `ForEach-Object`

**Try it (pipeline objects):**
```powershell
# Show that Get-Process outputs rich objects, then select useful properties
Get-Process | Get-Member -MemberType Property | Select-Object -First 5
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 Name, CPU
```

### `$null`: when and why
- `$null` means no value (not 0, not empty string)
- Use it to check if something was not found or not assigned
- Use it to suppress output when desired: `$null = Some-Command`
- Best-practice check style: `$null -eq $value`

**Try it (`$null`):**
```powershell
$svc = Get-Service -Name NotARealService -ErrorAction SilentlyContinue
if ($null -eq $svc) {
	"Service not found"
}
```

### Hashtables: when to use them
- Store key/value pairs for settings, lookups, and parameters
- Great for splatting parameters into commands/functions
- Fast lookups by key compared to scanning arrays

**Try it (hashtable + splatting):**
```powershell
$params = @{
	Path        = "C:\Scripts"
	Filter      = "*.ps1"
	File        = $true
	ErrorAction = "Stop"
}

Get-ChildItem @params | Select-Object Name, Length
```

---

## Updating PowerShell 7

- **Best method:** `winget upgrade Microsoft.PowerShell`
- **Alt:** Download MSI from GitHub releases page
- If winget says "install technology is different": `winget uninstall Microsoft.PowerShell` then `winget install Microsoft.PowerShell`
- **Verify version:** `$PSVersionTable.PSVersion`
- Always close & reopen terminal after updating

---

## VS Code Debugging Error: "does not support debugging this file type"

### Why it happens
- Active file is not recognized as a normal PowerShell script
- Wrong debugger profile selected in Run and Debug
- File language mode is Plain Text instead of PowerShell
- PowerShell extension session is not attached to pwsh 7

### Most common fix
- Rename script to a normal name like `test-script.ps1` (avoid using only `.ps1` as a filename)
- In VS Code bottom-right language mode, select PowerShell
- Open Command Palette and run: `PowerShell: Show Session Menu` then select PowerShell 7
- Start with Run and Debug using PowerShell: Launch Current File

**Try it:**
```powershell
# Confirm extension sees your script as a .ps1 and run it directly
Set-Location C:\Scripts
Rename-Item .\.ps1 test-script.ps1 -ErrorAction SilentlyContinue
pwsh -NoProfile -File .\test-script.ps1
```

---

## VS Code Runs Script In 5.1 Instead Of pwsh 7

### Why it happens
- VS Code terminal profile and PowerShell extension session are separate choices
- Run/Debug can use a PowerShell extension session still set to Windows PowerShell 5.1
- A launch profile may target `powershell.exe` instead of `pwsh.exe`

### Fix checklist
- Command Palette: `PowerShell: Show Session Menu` -> select PowerShell 7
- Command Palette: `PowerShell: Restart Current Session`
- Open Run and Debug, choose PowerShell launch profile for current file
- In terminal profile picker, set default profile to PowerShell 7 (`pwsh`)

### Optional setting checks
- `powershell.powerShellDefaultVersion` should point to PowerShell 7
- Remove old launch configs that explicitly use `powershell.exe`

**Try it:**
```powershell
# Verify what shell your script is actually running in
$PSVersionTable.PSVersion
$PSVersionTable.PSEdition
```

---

