# PowerShell 7 Learning Roadmap

---

## Phase 1 — Foundations
> Get comfortable with the shell and core concepts.

- [✔] Install PowerShell 7 (`winget install Microsoft.PowerShell`)
- [ ] Understand the difference between Windows PowerShell 5.1 vs PowerShell 7
- [✔] Learn the help system: `Get-Help`, `Get-Command`, `Get-Member`
- [✔] Navigate the filesystem: `Set-Location`, `Get-ChildItem`, `Get-Item`
- [✔] Work with variables, data types, and automatic variables (`$_`, `$PSVersionTable`, `$null`)
- [ ] Understand the pipeline and object-based output
- [ ] Use pipelines: `Where-Object`, `Select-Object`, `Sort-Object`, `ForEach-Object`
- [ ] Format output: `Format-Table`, `Format-List`, `Out-File`, `Export-Csv`
- [ ] String manipulation: `-replace`, `-match`, `-split`, string interpolation
- [ ] Understand operators: comparison (`-eq`, `-like`, `-match`), logical (`-and`, `-or`)

---

## Phase 2 — Control Flow & Scripting Basics
> Write real scripts with logic.

- [ ] `if` / `elseif` / `else`
- [ ] `switch` statements (including `-Regex`, `-Wildcard`)
- [ ] `for`, `foreach`, `while`, `do-while`, `do-until` loops
- [ ] `break`, `continue`, and labeled loops
- [ ] Write and call functions with `param()` blocks
- [ ] Understand scopes: global, script, local, private
- [ ] Use `[CmdletBinding()]` and `[Parameter()]` attributes
- [ ] Accept pipeline input in functions (`ValueFromPipeline`)
- [ ] `begin` / `process` / `end` blocks
- [ ] Error handling: `try` / `catch` / `finally`, `$ErrorActionPreference`
- [ ] Terminating vs non-terminating errors, `-ErrorAction`

---

## Phase 3 — Intermediate Concepts
> Deepen understanding and write production-quality scripts.

- [ ] Work with arrays, hashtables, and `[PSCustomObject]`
- [ ] Splatting (`@params`)
- [ ] Regular expressions in depth
- [ ] File I/O: `Get-Content`, `Set-Content`, `Add-Content`, JSON/XML/CSV
- [ ] Date and time: `Get-Date`, `[datetime]`, `New-TimeSpan`
- [ ] Providers and PSDrives (Registry, Cert, Env, etc.)
- [ ] Use `Invoke-Command` for local and remote execution
- [ ] PowerShell remoting with `Enter-PSSession` / `New-PSSession`
- [ ] Background jobs: `Start-Job`, `Receive-Job`, `Start-ThreadJob`
- [ ] Understand execution policies and script signing

---

## Phase 4 — PowerShell 7 Specific Features
> Leverage what's new in pwsh 7.

- [ ] Ternary operator: `$x ? 'yes' : 'no'`
- [ ] Null-coalescing: `$x ?? 'default'`
- [ ] Null-conditional access: `${x}?.Method()`
- [ ] Pipeline chain operators: `&&` and `||`
- [ ] `ForEach-Object -Parallel` for parallel execution
- [ ] New `Get-Error` for rich error inspection
- [ ] `$PSStyle` for ANSI terminal styling
- [ ] `Clean` block in functions (in addition to begin/process/end)
- [ ] SSH-based remoting (`New-PSSession -HostName`)
- [ ] Cross-platform considerations (Linux/macOS paths, filesystem case sensitivity)

---

## Phase 5 — Modules & Toolmaking
> Build reusable, distributable tools.

- [ ] Understand module structure: `.psm1`, `.psd1`, manifest
- [ ] Create a script module with exported functions
- [ ] Use `Export-ModuleMember` and manifest `FunctionsToExport`
- [ ] Install and manage modules from PSGallery (`Install-Module`, `Update-Module`)
- [ ] Write comment-based help (`<# .SYNOPSIS ... #>`)
- [ ] Add `ShouldProcess` support (`-WhatIf`, `-Confirm`)
- [ ] Understand module auto-loading and `$env:PSModulePath`
- [ ] Create Crescendo modules (wrap native CLI tools in cmdlets)
- [ ] Publish a module to PSGallery

---

## Phase 6 — Real-World Tasks
> Apply skills to common IT/DevOps scenarios.

- [ ] Active Directory management (`ActiveDirectory` module)
- [ ] Manage Windows services, processes, and scheduled tasks
- [ ] Network diagnostics (`Test-Connection`, `Resolve-DnsName`, `Test-NetConnection`)
- [ ] Interact with REST APIs (`Invoke-RestMethod`, `Invoke-WebRequest`)
- [ ] Parse and manipulate JSON (`ConvertFrom-Json`, `ConvertTo-Json`)
- [ ] Work with the Windows Registry
- [ ] Manage local users and groups
- [ ] Automate file/folder operations (backup, cleanup, archival)
- [ ] Generate HTML reports (`ConvertTo-Html`)
- [ ] Log to files with timestamps

---

## Phase 7 — Advanced Patterns
> Level up to expert.

- [ ] Classes in PowerShell (`class`, `enum`, inheritance)
- [ ] DSC (Desired State Configuration) basics
- [ ] SecretManagement module for credential handling
- [ ] Build and use custom argument completers (`Register-ArgumentCompleter`)
- [ ] Write Pester tests for your scripts/modules
- [ ] Use `PSScriptAnalyzer` for linting and best practices
- [ ] CI/CD pipelines with PowerShell (GitHub Actions, Azure DevOps)
- [ ] Performance tuning: avoid pipeline when speed matters, use `[System.Collections.Generic.List[T]]`
- [ ] Directly call .NET APIs from PowerShell
- [ ] Build CLI tools with `System.CommandLine` or Crescendo

---

## Recommended Resources

| Resource | Type |
|---|---|
| `Get-Help about_*` | Built-in docs (run in terminal) |
| [Microsoft Learn — PowerShell](https://learn.microsoft.com/en-us/powershell/) | Official docs |
| *Learn PowerShell in a Month of Lunches* (4th ed.) | Book |
| *PowerShell Cookbook* (Lee Holmes) | Book |
| [PowerShell GitHub repo](https://github.com/PowerShell/PowerShell) | Source / issues |
| r/PowerShell | Community |
| PowerShell Discord | Community |

---

*Track progress by checking off items as you go. Revisit phases as needed — learning is not strictly linear.*
