# Get Git niceness in PS
Import-Module -Name posh-git
Import-Module -Name oh-my-posh
Set-Theme Paradox

# **** oh-my-posh prompt Settings Start *****
$ThemeSettings.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0xE285)
$ThemeSettings.PromptSymbols.FailedCommandSymbol = [char]::ConvertFromUtf32(0xF00D)
$ThemeSettings.PromptSymbols.UNCSymbol = "§"
$ThemeSettings.GitSymbols.LocalWorkingStatusSymbol = "☢"
$ThemeSettings.GitSymbols.LocalDefaultStatusSymbol = "✔"
$ThemeSettings.GitSymbols.BranchIdenticalStatusToSymbol = ""
$ThemeSettings.GitSymbols.BranchAheadStatusSymbol = "☁ "
$ThemeSettings.GitSymbols.BranchUntrackedSymbol = [char]::ConvertFromUtf32(0xE36E)
# **** oh-my-posh prompt Settings End *****

# Make ls work more like unix ls
Import-Module Get-ChildItemColor
Set-Alias l Get-ChildItemColor -option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -option AllScope

# Alias git to g, because it takes to long to type out git
Set-Alias g git

# **** PoshGit Prompt Settings Start *****

# Don't show statuses when they are zero
$GitPromptSettings.ShowStatusWhenZero = $false


# **** PoshGit Prompt Settings End *****

# Import PSReadLine
#Import-Module PSReadLine

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

# Deletes any local branches that have been deleted from the remote repo
function gbpurge {
	git checkout master; git remote update origin --prune; git branch -vv | Select-String -Pattern ": gone]" | % { $_.toString().Trim().Split(" ")[0]} | % {git branch -d $_}
}