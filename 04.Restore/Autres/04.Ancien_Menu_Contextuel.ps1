try {
    $existingProperty = Get-ItemProperty -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -ErrorAction Stop
}
catch {
    Write-Output "The 'InprocServer32' property does not exist."
    $existingProperty = $null
}
Clear-Host
if ($null -eq $existingProperty) {
    New-Item -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Value "" -Force
    Get-Process explorer | Stop-Process
    Write-Host "Menu Contextuel activé" -ForegroundColor Green
}else {
    Write-Host "Menu Contextuel déjà activé" -ForegroundColor Green
}
 