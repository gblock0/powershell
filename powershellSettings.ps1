# Get Git niceness in PS
Import-Module -Name posh-git

# Make ls work more like unix ls
Import-Module Get-ChildItemColor
Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

# Alias git to g, because it takes to long to type out git
Set-Alias g git

# **** PoshGit Prompt Settings Start *****

# Show time before Path and VCS info
$GitPromptSettings.DefaultPromptPrefix.Text = '$(Get-Date -f "MM-dd HH:mm:ss") '
$GitPromptSettings.DefaultPromptPrefix.ForegroundColor = [ConsoleColor]::Magenta
$GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`n'

# Use a green checkmark to show that the local repo isn't dirty
$GitPromptSettings.LocalDefaultStatusSymbol.Text = "✔"
$GitPromptSettings.LocalDefaultStatusSymbol.ForegroundColor = [ConsoleColor]::DarkGreen

# Turn off showing that the local branch is identical to the remote
$GitPromptSettings.BranchIdenticalStatusSymbol.Text = ""

# Change the default symbol that shows the local is ahead of remote
$GitPromptSettings.BranchAheadStatusSymbol.Text = "☁"
$GitPromptSettings.BranchIdenticalStatusSymbol.ForegroundColor = [ConsoleColor]::Magenta

# Don't show statuses when they are zero
$GitPromptSettings.ShowStatusWhenZero = $false

# Change the default dirty symbol
$GitPromptSettings.LocalWorkingStatusSymbol.Text = "☢"

# **** PoshGit Prompt Settings End *****

# Import PSReadLine
Import-Module PSReadLine

# **** PSReadLine Settings Start *****
# History Options
Set-PSReadLineOption -HistoryNoDuplicates
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
Set-PSReadLineOption -MaximumHistoryCount 4000

# History substring search
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab completion
Set-PSReadlineKeyHandler -Chord 'Shift+Tab' -Function Complete
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
# **** PSReadLine Settings End *****