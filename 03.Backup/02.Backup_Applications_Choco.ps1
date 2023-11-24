if ($env:COMPUTERNAME -match "Fixe") {$prefix = "PC-Fixe"} elseif ($env:COMPUTERNAME -match "Portable") {$prefix = "PC-Portable"} else {$prefix = "PC-Inconnu"}
$DossierConfigBackupSurNas = "V:\03.PC\01.WINDOWS\01.DOSSIERS_CONFIG\$prefix"
$dateTime = Get-Date -Format 'dd-MM-yyyy_HH.mm'
$DestinationFolderChoco = "$DossierConfigBackupSurNas\Choco"
$fichierconfigchoco = "$prefix`_$dateTime`_choco_packages.config"
choco export -o "$DestinationFolderChoco\$fichierconfigchoco" -v --skipcompatibilitychecks --allowunofficial -f
$xmlContent = Get-Content -Path "$DestinationFolderChoco\$fichierconfigchoco" -Raw
$xml = [xml]$xmlContent
$packageIds = $xml.packages.package | ForEach-Object { $_.id }
$packageIds | Out-File "C:\TempChoco.txt"
$fichierbackupchoco = "$prefix`_$dateTime`_choco_packages.ps1"
(Get-Content "C:\TempChoco.txt") | ForEach-Object { "'$_' `nchoco install $_" } | Set-Content "$DestinationFolderChoco\$fichierbackupchoco"
"`n# Autres options Choco Utiles `n# --ignoredetectedreboot --allowemptychecksumsecure --allowemptychecksum --ignorechecksum --skipcompatibilitychecks --allowunofficial --force --yes --acceptlicense" | Add-Content "$DestinationFolderChoco\$fichierbackupchoco"
Remove-Item "C:\TempChoco.txt"

$nombreFichiers = 3
$listeFichiers = Get-ChildItem "$DestinationFolderChoco" -Filter "*.ps1" | Where-Object { $_.Name -like "*$prefix*" } | Sort-Object CreationTime
if ($listeFichiers.Count -gt $nombreFichiers) {
$listeFichiers[0..($listeFichiers.Count - $nombreFichiers - 1)] | Remove-Item -Force
}

$DeleteConfigFiles = Get-ChildItem "$DestinationFolderChoco" -Filter "*.config"
if ($DeleteConfigFiles) {
    foreach ($files in $DeleteConfigFiles){
        Remove-Item -Path $files -Force
}}

$DeleteConfigFiles = Get-ChildItem "$DestinationFolderChoco" -Filter "*.backup"
if ($DeleteConfigFiles) {
    foreach ($files in $DeleteConfigFiles){
        Remove-Item -Path $files -Force
}}
 