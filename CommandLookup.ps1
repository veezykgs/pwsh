# CommandLookup.ps1
# Search for commands by keyword and view help examples
# Practice: Get-Command, Get-Help, pipeline objects, variables

do {
    $keyword = Read-Host "`nEnter a keyword to search (or 'q' to quit)"

    if ($keyword -eq 'q') { break }

    # Find matching commands
    $results = Get-Command "*$keyword*" -ErrorAction SilentlyContinue

    if ($null -eq $results) { # $null -eq $results is a common way to check if the Get-Command returned any results. If no commands match the search pattern, Get-Command will return $null. This check allows the script to handle the case where no commands are found and inform the user accordingly.
        "No commands found for '$keyword'"
        continue
    }
    # Show results as a numbered list
    "`n--- Commands found ---" # `n is a newline character that adds a blank line before the "Commands found" header, improving readability. The foreach loop iterates through each command in the $results collection, displaying its name and command type in a numbered list format. This allows the user to easily identify and select a command for further exploration.
    $i = 1 # Initialize a counter variable to keep track of the command numbers in the list. This variable is incremented for each command displayed, allowing the user to reference commands by their corresponding number when making a selection.
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
