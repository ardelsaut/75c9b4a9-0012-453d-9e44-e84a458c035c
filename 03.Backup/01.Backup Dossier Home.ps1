if ($env:COMPUTERNAME -match "Fixe") {$prefix = "PC-Fixe"} elseif ($env:COMPUTERNAME -match "Portable") {$prefix = "PC-Portable"} else {$prefix = "PC-Inconnu"}
$dateTime = Get-Date -Format 'dd-MM-yyyy_HH.mm'
$DossierConfigBackupSurNas = "V:\03.PC\01.WINDOWS\01.DOSSIERS_CONFIG\$prefix"
$ExcludeListBackupConfig = "$env:TEMP\ExcludeListBackupConfig.txt"
if (Test-Path -Path "$ExcludeListBackupConfig") {Remove-Item -Path "$ExcludeListBackupConfig" -Force -ErrorAction SilentlyContinue  | Out-Null}
@"
AppData\Local\Temp\
AppData\Local\Adobe\
AppData\Local\blitz-updater\
AppData\Local\cache\
AppData\Local\IconCache.db
AppData\Local\CEF\
AppData\Local\Comms\
AppData\Local\ConnectedDevicesPlatform\
AppData\Local\CrashDumps\
AppData\Local\D3DSCache\
AppData\Local\EADesktop\
AppData\Local\EALaunchHelper\
AppData\Local\Historique\
AppData\Local\Link2EA\
AppData\Local\Microsoft\
AppData\Local\NhNotifSys\
AppData\Local\NVIDIA\
AppData\Local\NVIDIA Corporation\
AppData\Local\Package Cache\
AppData\Local\PackageManagement\
AppData\Local\PeerDistRepub\
AppData\Local\PlaceholderTileLogoFolder\
AppData\Local\Programs\
AppData\Local\Publishers\
AppData\Local\SquirrelTemp\
AppData\Local\Temporary Internet Files\
AppData\LocalLow\
NTUSER.DAT
OneDrive\
Favorites\
ntuser.ini
Searches\
Modeles\
Cookies\
Recent\
SendTo\
Application Data\
Start Menu\
Local Settings\
My Music\
My Pictures\
My Videos\
Start Menu\
My Documents\
Templates\
PrintHood\
Network Shortcuts\
"@ | Out-File -Encoding utf8 -FilePath "$ExcludeListBackupConfig"
$archivePath = "$DossierConfigBackupSurNas\Config_${prefix}_${dateTime}.zip"
7z.exe a "$archivePath" "$env:userprofile/*" -xr0!"*desktop.ini" -xr@"$ExcludeListBackupConfig"

$PathDossierConfigProgrammesNas = "V:\03.PC\01.WINDOWS\01.DOSSIERS_CONFIG\A_INSTALLER_MANUELLEMENT\Programmes"
if (!(Test-Path -Path "$PathDossierConfigProgrammesNas\wt-config")) {New-Item -Path "$PathDossierConfigProgrammesNas" -Name "wt-config" -ItemType Directory -Force}
XCOPY /Y /E /H "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "$PathDossierConfigProgrammesNas\wt-config\"
XCOPY /Y /E /H "$env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt" "$PathDossierConfigProgrammesNas\wt-config\"
 