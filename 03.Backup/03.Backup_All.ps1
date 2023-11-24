$ALLPs1 = (Get-ChildItem "$env:TEMP\NonoOS\Menus\03.Backup\*" -Exclude "*.Backup_All.ps1").FullName

foreach ($Item in $ALLPs1) {
    Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $Item -WindowStyle Normal" -NoNewWindow -Wait
}