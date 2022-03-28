$LnkPath = "$env:APPDATA/Microsoft/Windows/Start Menu/Programs/Startup/"
$LnkName = "OK Defender.lnk"
$PwshCmd = "powershell.exe" 
$PwshArg = "-command $PSScriptRoot/ok_defender.ps1"

$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut($LnkPath + $LnkName)
$Shortcut.TargetPath = $PwshCmd
$Shortcut.Arguments = $PwshArg
$Shortcut.Save()
