if ((Get-ItemPropertyValue -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon) -ne "1") {
    Clear-Host
    Write-Host "Mise en place de 'autologon' pour $env:USERNAME" -ForegroundColor Cyan
    Write-Host "Veuillez entrer le Mot de passe de connexion a l ordinateur: " -NoNewline -ForegroundColor Cyan
    $passwordwin = Read-Host 
    Clear-Host
    Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultUserName -Value $env:USERNAME
    Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name DefaultPassword -Value $passwordwin
    Set-ItemProperty -Path 'registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoAdminLogon -Value "1"
    Clear-Host
    Write-Host "Autologon active" -ForegroundColor Green
}