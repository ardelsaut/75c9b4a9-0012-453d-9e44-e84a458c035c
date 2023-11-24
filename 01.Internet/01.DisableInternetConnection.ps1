$scriptName = Split-Path -Path "$PSCommandPath" -Leaf
$host.ui.RawUI.WindowTitle = "$scriptName"
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}
Clear-Host
# Equivalent $PSScriptRoot

$DossierTacheSurHome = "$env:USERPROFILE\Documents\1.Scripts"

$PathApp = "$DossierTacheSurHome\$scriptName"
if (!(Test-Path -Path "$PathApp")) {
    Get-Content "$PSCommandPath" | Add-Content -Path "$PathApp" -Force
}

try {
    $existingProperty = Get-ScheduledTask -TaskName "$scriptName" -ErrorAction Stop}
catch {    Write-Output "La Tache '$scriptName' n'existe pas."
    $existingProperty = $null}
if ($null -eq $existingProperty){
    if ($scriptName -like "*.ps1"){
        $A = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $PathApp"
    } else {
        $A = New-ScheduledTaskAction -Execute "$PathApp"
    }
    $AdministrateurOuAdministrator = (Get-LocalGroup | Where-Object { $_.Name -match "Adminis*" } |  Select-Object -First 1).Name
    $scriptName = Split-Path -Path $PSCommandPath -Leaf
    $GroupIdFrench = "BUILTIN\$AdministrateurOuAdministrator"
    $P = New-ScheduledTaskPrincipal -GroupId "$GroupIdFrench" -RunLevel Highest
    $S = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0
    $D = New-ScheduledTask -Action $A -Principal $P -Settings $S
    Register-ScheduledTask "$scriptName" -InputObject $D -TaskPath "\NonoOs"
}

if(!(Get-NetFirewallRule -DisplayName "InternetAccessBlock1" -ErrorAction SilentlyContinue)) {
    Write-Host "Actuellement, la règle est désactivée" -ForegroundColor Red

} else {
    Write-Host "Actuellement, la règle est activée" -ForegroundColor Green
}
Start-Sleep -Milliseconds 500
Write-Host "Voulez-vous activer ou désactiver le blocage de la connexion avec le firewall?"
Write-Host "1 : Activer"
$Question = Read-Host  "2 : Désactiver"

if ($Question -eq 1) {
    New-NetFirewallRule -DisplayName "InternetAccessBlock1" -Direction Outbound -Action Block -RemoteAddress "0.0.0.0-192.168.0.255"
    New-NetFirewallRule -DisplayName "InternetAccessBlock2" -Direction Outbound -Action Block -RemoteAddress "192.168.2.0-255.255.255.255"
    Start-Sleep -Milliseconds 500
    Clear-Host
    Write-Host "Le blocage de la connexion avec le firewall est activé" -ForegroundColor Cyan
    Start-Sleep -Milliseconds 2000
    Write-Host "Le blocage de la connexion avec le firewall est actif" -ForegroundColor Cyan
    Write-Host "Voulez-vous le déactiver?"
    Write-Host "1 : oui"
    $Question = Read-Host "2 : Quitter"
    if ($Question -eq 1) {
        Remove-NetFirewallRule -DisplayName "InternetAccessBlock1"
        Remove-NetFirewallRule -DisplayName "InternetAccessBlock2"        
        Start-Sleep -Milliseconds 500
        Clear-Host
        Write-Host "Le blocage de la connexion avec le firewall est désactivé." -ForegroundColor Cyan
        Start-Sleep -Milliseconds 2000
        Clear-Host
        exit
    }
    exit
} elseif ($Question -eq 2) {
    if((Get-NetFirewallRule -DisplayName "InternetAccessBlock1" -ErrorAction SilentlyContinue)) {
        Remove-NetFirewallRule -DisplayName "InternetAccessBlock1"
        Remove-NetFirewallRule -DisplayName "InternetAccessBlock2"        
        Start-Sleep -Milliseconds 500
        Clear-Host
        Write-Host "Le blocage de la connexion avec le firewall est désactivé." -ForegroundColor Cyan
        Start-Sleep -Milliseconds 2000
        Clear-Host
    } else {
        Write-Host "La règle était déjà désactivée...On quitte le programme."
        Start-Sleep -Milliseconds 2000
        exit
    }
} else {
    Write-Host "Erreur d'input... On quitte le programme."
    Start-Sleep -Milliseconds 500
    exit
}









