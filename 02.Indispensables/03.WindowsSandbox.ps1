Clear-Host
# Fonction pour obtenir $PSCommandPath
Function Get-PSScriptPath {
    if ([System.IO.Path]::GetExtension($PSCommandPath) -eq '.ps1') {
        $psScriptPath = $PSCommandPath
    }
    else {
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
# Début du log
$NomFichierLog = Get-Date -Format "dd-MM-yy--HH.mm.ss"
$pathFichierLog = "C:\Logs\$scriptName\$NomFichierLog.txt"
# Start-Transcript -Path "$pathFichierLog" -Append -Force -IncludeInvocationHeader -UseMinimalHeader
Start-Transcript -Path "$pathFichierLog" -Append -Force -IncludeInvocationHeader | Out-Null
$IsSandboxInstalled = Get-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM"
if (!($IsSandboxInstalled.State -eq "Enabled")){
  Enable-WindowsOptionalFeature -Online -FeatureName "Containers-DisposableClientVM" -All
  Write-Host "WindowsSandbox n'était pas activé, il faut peut-être redémarré le pc."
  Write-Host " 3 " -NoNewline -ForegroundColor Cyan
  Start-Sleep -Seconds 1
  Write-Host " 2 " -NoNewline -ForegroundColor Cyan
  Start-Sleep -Seconds 1
  Write-Host " 1 " -NoNewline -ForegroundColor Cyan
  Start-Sleep -Seconds 1
  Write-Host " 0 " -NoNewline -ForegroundColor Cyan
  Start-Sleep -Seconds 1
}
$FichierWsb = "$env:TEMP\WindowsSandbox.wsb"
if (Test-Path -Path "$FichierWsb") {
    Remove-Item -Path "$FichierWsb" -Recurse -Force  | Out-Null
} 
New-Item -Path "$FichierWsb" -ItemType File -Force  | Out-Null
# Add the configuration text to the file
# @"
# <Configuration>
#   <VGPU>Enable</VGPU>
#   <Networking>Enable</Networking>
#   <MappedFolders>
#     <MappedFolder>
#       <HostFolder>V:\03.PC\01.WINDOWS</HostFolder>
#       <ReadOnly>true</ReadOnly>
#     </MappedFolder>
#   </MappedFolders>
#   <LogonCommand>
#     <Command></Command>
#   </LogonCommand>
#   <AudioInput>Enable</AudioInput>
#   <VideoInput>Enable</VideoInput>
#   <ProtectedClient>Default</ProtectedClient>
#   <PrinterRedirection>enable</PrinterRedirection>
#   <ClipboardRedirection>Enable</ClipboardRedirection>
#   <MemoryInMB>8192</MemoryInMB>
# </Configuration>
# "@ | Out-File "$FichierWsb"
@"
<Configuration>
  <VGPU>Enable</VGPU>
  <Networking>Enable</Networking>
  <AudioInput>Enable</AudioInput>
  <VideoInput>Enable</VideoInput>
  <ProtectedClient>Default</ProtectedClient>
  <PrinterRedirection>enable</PrinterRedirection>
  <ClipboardRedirection>Enable</ClipboardRedirection>
  <MemoryInMB>8192</MemoryInMB>
</Configuration>
"@ | Out-File "$FichierWsb"


Start-Process -FilePath "$env:SystemRoot\System32\WindowsSandbox.exe" -ArgumentList "$FichierWsb"
Clear-Host
Write-Host "$FichierWsb lancé"
Start-Sleep -Seconds 5
Remove-Item -Path "$FichierWsb" -Recurse -Force | Out-Null
Clear-Host
### Fin Script ###
##################
$directoryPath = "C:\Logs\$scriptName"
$itemsToKeep = 9
$items = Get-ChildItem -Path $directoryPath | Sort-Object CreationTime -Descending
$itemsToRemove = $items.Count - $itemsToKeep
if ($itemsToRemove -gt 0) {
    $itemsToRemoveList = $items | Select-Object -Last $itemsToRemove
    $itemsToRemoveList | Remove-Item -Force
}
Stop-Transcript | Out-Null
