$WindowsUpdateServices = ("wuauserv", "WaaSMedicSvc", "UsoSvc")
$WindowsUpdateServices | ForEach-Object{
    Set-Service -Name $_ -StartupType Automatic -ErrorAction SilentlyContinue | Out-Null
    Start-Service -Name $_ -ErrorAction SilentlyContinue | Out-Null
}
Enable-ScheduledTask -TaskName "\Microsoft\Windows\WindowsUpdate\Scheduled Start" | Out-Null
if (!(Test-Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings")){
    New-Item -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Name "UxOption" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\WaaSMedicSvc" -Name Start -Value 2
Clear-Host

##########

if (!(Get-Module -ListAvailable -Name PSWindowsUpdate)) {
    Write-Host "Y" | powershell "Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force"
    Set-PSRepository -InstallationPolicy Trusted -Name PSGallery
    Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck -Confirm:$false
    Import-Module PSWindowsUpdate -Confirm:$false
}
Get-WindowsUpdate -AcceptAll -Download -Install -IgnoreReboot -Verbose
 

