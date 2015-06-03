# There's usually much more than this in my profile!
$SCRIPTPATH = "C:\Users\gblock\Scripts"
$VIMPATH    = "C:\Program Files (x86)\Vim\vim74\gvim.exe"

Set-Alias vi   $VIMPATH
Set-Alias vim  $VIMPATH
Set-Alias mvim  $VIMPATH

# for editing your PowerShell profile
Function Edit-Profile
{
    vim $profile
}

# for editing your Vim settings
Function Edit-Vimrc
{
    vim $home\_vimrc
}


# Set up a simple prompt, adding the hg prompt parts inside hg repos

# SET YOUR COLORS HERE
$branchFGColor = "Green"
$branchFGDirtyColor = "red"
$bookmarkFGColor = "Yellow"
$patchFGColor = "Green"
$bgColor = $Host.UI.RawUI.BackgroundColor

#function prompt {
#	Write-Host $pwd -nonewline
#	$hginfo = hg prompt "{branch}:{status}" | Out-String
#	$hginfo = $hginfo.Trim()
#	if ($hginfo.Length -gt 0) {
#		$parts = $hginfo.Split(":")
#		$branch = $parts[0]
#		$status = $parts[1]
#		Write-Host -nonewline " ["
#		if ($status.Length -gt 0){
#			Write-Host -nonewline -BackgroundColor $bgColor -ForegroundColor $branchFGDirtyColor $branch$status
#		}else{
#			Write-Host -nonewline -BackgroundColor $bgColor -ForegroundColor $branchFGColor $branch$status
#		}
#				Write-Host -nonewline "]"
#	}
#	Return "> "
#}

# Function to change to the root of the Relativity source code directory
function trunk { 
	cd $env:trunk
}

function diffs{
	hg st; hg diff
}

function pushjs{
	$jsHintOutput = runjshint;
	$jsHintFailed = $jsHintOutput | Select-String -Pattern "BUILD FAILED" -SimpleMatch;
	If ($jsHintFailed.Length -gt 0)
	{
		echo "JS Hint Failed! (-_-;)";
		$pos = $jsHintOutput.IndexOf("test_relativity_jshint:");
		$foundTestRelativityJSHint = $FALSE;
		foreach($line in $jsHintOutput)
		{
			If($line -eq "BUILD FAILED"){
				$foundTestRelativityJSHint = $FALSE;
			}
			If($foundTestRelativityJSHint){
				echo $line;
			}
			If($line -eq "test_relativity_jshint:"){
				$foundTestRelativityJSHint = $TRUE;
			}
		}
	}Else{
		hg push -b .;
	}
}

function jsTest(){
	trunk; pushjs;
}

# Load posh-hg example profile
. 'C:\Users\gblock\Documents\WindowsPowerShell\Modules\posh-hg\profile.example.ps1'

