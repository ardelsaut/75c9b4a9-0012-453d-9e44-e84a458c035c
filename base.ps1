Clear-Host
# Fonction pour obtenir $PSCommandPath
Function Get-PSScriptPath {
    if ([System.IO.Path]::GetExtension($PSCommandPath) -eq '.ps1') {
        $psScriptPath = $PSCommandPath
    } else {
        $psScriptPath = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
    }
    return $psScriptPath
}
# On verifie que le script tourne bien avec les droits eleves
$NewPSCommandPath = Get-PSScriptPath
$scriptName = Split-Path -Path $NewPSCommandPath -Leaf
$host.ui.RawUI.WindowTitle = "$scriptName"
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$NewPSCommandPath`"" -Verb RunAs
    exit
}
Clear-Host
# Equivalent $PSScriptRoot
$NewPSScriptRoot = if (-not $PSScriptRoot) { Split-Path -Parent (Convert-Path ([environment]::GetCommandLineArgs()[0])) } else { $PSScriptRoot }
$NewPSScriptRoot | Out-Null

if (Test-Path -Path "$env:ProgramFiles\PowerShell\7\pwsh.exe" -ErrorAction SilentlyContinue) {
    $ExePowershell = "$env:ProgramFiles\PowerShell\7\pwsh.exe"
} else {
    $ExePowershell = "$env:SystemRoot\System32\WindowsPowerShell\v1.0\powershell.exe"
}

$Change_Policy_File = "C:\Windows\NonoOS\Change_Policy_File"
if (!(Test-Path -Path $Change_Policy_File -ErrorAction SilentlyContinue)) {
    Write-Host "Lancement du script pour la premiere fois." -ForegroundColor Cyan
    Write-Host "Mise en place des parametres necessaires au bon fonctionnement du script." -ForegroundColor Cyan
    Write-Host "Veuillez patienter..." -ForegroundColor Cyan

    New-Item -Path $Change_Policy_File -ItemType File -Force | Out-Null

    if (!((Get-ItemProperty HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell).ExecutionPolicy -like "Unrestriced" )) {
        Set-ItemProperty "HKLM:\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" -Name "ExecutionPolicy" -Value "Unrestriced"
    }
    if (!(Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments")) {
        New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "SaveZoneInformation" -Value 2 -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments" -Name "InclusionList" -Value "*.bat;*.exe;*.ps1" | Out-Null
    }
    if (!(Test-Path -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Associations")) {
        New-Item "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" -Force | Out-Null
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Associations" -Name "LowRiskFileTypes" -Value "*.bat;*.exe;*.ps1" | Out-Null
    }
    set-location "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings";
    set-location ZoneMap\Domains;
    new-item nonobouli.myds.me/ -Force | Out-Null
    set-location nonobouli.myds.me/
    new-itemproperty . -Name https -Value 2 -Type DWORD -Force  | Out-Null
    Set-Location ..
    new-item *.nonobouli.myds.me/ -Force | Out-Null
    set-location *.nonobouli.myds.me/ | Out-Null
    new-itemproperty . -Name https -Value 2 -Type DWORD -Force | Out-Null
    Set-Location ..
    new-item 192.168.1.54/ -Force  | Out-Null
    set-location 192.168.1.54/
    new-itemproperty . -Name https -Value 2 -Type DWORD -Force | Out-Null
    Set-Location ..
    new-item *.192.168.1.54/ -Force  | Out-Null
    set-location *.192.168.1.54/
    new-itemproperty . -Name https -Value 2 -Type DWORD -Force  | Out-Null
    Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Name "2500" -Value "3"  | Out-Null
    Set-ItemProperty -path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\2" -Name "1A10" -Value "0"  | Out-Null
    taskkill /f /im explorer.exe | Out-Null
    Start-Process explorer.exe | Out-Null
    gpupdate /force | Out-Null
}

Clear-Host

Write-Host "Veuillez choisir le(s) script(s) a executer..." -ForegroundColor Cyan
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Speech
do {
    $f = New-Object System.Windows.Forms.OpenFileDialog
    $test = Resolve-Path -Path "$NewPSScriptRoot\..\..\Menus"
    $f.InitialDirectory = $test
    $f.Filter = "Fichiers Powershell(*.ps1)|*.ps1;|Tous les Fichiers (*.*)|*.*"
    $f.Multiselect = $true
    $result = $f.ShowDialog()
    $User32 = Add-Type -Debug:$False -MemberDefinition '[DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X,int Y, int cx, int cy, uint uFlags);' -Name "User32Functions" -namespace User32Functions -PassThru -ErrorAction SilentlyContinue
    [Void]$User32::SetWindowPos($hwnd, -1, 0, 0, 0, 0, 0x53)
    if ($result -eq [System.Windows.Forms.DialogResult]::OK -and $f.Multiselect) {
        foreach ($p in $f.FileNames) {
            Clear-Host
            Write-Host "Lancement du script: $p" -ForegroundColor Yellow
            & $ExePowershell -ExecutionPolicy Bypass -File "$p"
            Write-Host "$p a ete execute." -ForegroundColor Yellow  -BackgroundColor DarkGreen
            $synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
            $synth.SelectVoice("Microsoft Zira Desktop")
            $synth.Rate = 1
            $synth.Volume = 100
            $synth.Speak("executed!")
        }
    }
} while ($result -eq [System.Windows.Forms.DialogResult]::OK -and $f.Multiselect)
exit