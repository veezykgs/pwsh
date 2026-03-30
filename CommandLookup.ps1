# CommandLookup.ps1
# Search for commands by keyword and view help examples
# Practice: Get-Command, Get-Help, pipeline objects, variables

do {
    $keyword = Read-Host "`nEnter a keyword to search (or 'q' to quit)"

    if ($keyword -eq 'q') { break }

    # Find matching commands
    $results = Get-Command "*$keyword*" -ErrorAction SilentlyContinue

    if ($null -eq $results) {
        "No commands found for '$keyword'"
        continue
    }

    # Show results as a numbered list
    "`n--- Commands found ---"
    $i = 1
    foreach ($cmd in $results) {
        "$i. $($cmd.Name)  [$($cmd.CommandType)]"
        $i++
    }

    # Let user pick one
    $choice = Read-Host "`nEnter the number of the command to see examples"
    $selected = @($results)[$choice - 1]

    if ($null -eq $selected) {
        "Invalid choice"
        continue
    }

    "`n--- Examples for $($selected.Name) ---"
    Get-Help $selected.Name -Examples

} while ($true)
