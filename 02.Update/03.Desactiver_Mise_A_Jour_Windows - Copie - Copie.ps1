$WindowsUpdateServices = ("wuauserv", "WaaSMedicSvc", "UsoSvc")
$WindowsUpdateServices | ForEach-Object{
Set-Service -Name $_ -StartupType Disabled -ErrorAction SilentlyContinue | Out-Null
Stop-Service -Name $_ -ErrorAction SilentlyContinue | Out-Null
}
Disable-ScheduledTask -TaskName "\Microsoft\Windows\WindowsUpdate\Scheduled Start" | Out-Null
if (!(Test-Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings")){
    New-Item -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Force | Out-Null
}
Set-ItemProperty -Path "HKLM:\Software\Microsoft\WindowsUpdate\UX\Settings" -Name "UxOption" -Type DWord -Value 1
Stop-Process -Name "MoUsoCoreWorker" -Force -PassThru -ErrorAction SilentlyContinue | Out-Null
Stop-Process -Name "TiWorker" -Force -PassThru -ErrorAction SilentlyContinue | Out-Null
Set-ItemProperty -Path "HKLM:\SYSTEM\ControlSet001\Services\WaaSMedicSvc" -Name Start -Value 4
 