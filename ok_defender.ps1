param([switch]$elevated)
    function checkAdmin {
        $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
        $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
    }

    if ((checkAdmin) -eq $false)  {
        if (-not $elevated) {
            Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -windowstyle normal -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
        }
        exit
    }

$Host.UI.RawUI.WindowTitle = "OK Defender"

$statusRefreshRateSec = 15

$trayIcon = (Get-AppxPackage Microsoft.Windows.SecHealthUI).installlocation + '\Assets\Threat.contrast-black.ico'
[void][System.Reflection.Assembly]::LoadWithPartialName("System.windows.forms")
$NotifyIcon = New-Object System.Windows.Forms.NotifyIcon
$NotifyIcon.Icon = $trayIcon
$NotifyIcon.Visible = $true

function Get-Status {
    param($targetParam)
    if ($targetParam) {Write-Host "ON" -ForegroundColor Green}
    else {Write-Host "OFF" -foregroundcolor Red}
}

function Show-Report {
    Clear-Host
    $defender = Get-MpComputerStatus

    Write-Host "`nTamper Protection    : " -NoNewLine
    Get-Status $defender.IsTamperProtected
    
    Write-Host "Real-time protection : " -NoNewLine
    Get-Status $defender.RealTimeProtectionEnabled
    
    Write-Host "`nPress " -NoNewLine
    Write-Host "Ctrl+C " -ForegroundColor White -NoNewLine
    Write-Host "to stop the script and enable Windows Defender real-time protection."
}

Show-Report

try {
    while ($true) {
        if ((Get-MpPreference).DisableRealtimeMonitoring -ne $true) {
            Set-MpPreference -DisableRealtimeMonitoring $true
            Start-Sleep -s 2
        } 
        else {
            Start-Sleep -s $statusRefreshRateSec
        }
        Show-Report
    }
}
finally {
    Set-MpPreference -DisableRealtimeMonitoring $false
    $NotifyIcon.Visible = $false
}
