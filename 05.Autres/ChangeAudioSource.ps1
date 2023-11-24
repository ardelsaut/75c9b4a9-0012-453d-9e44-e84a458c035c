Function Get-PSScriptPath {
    if ([System.IO.Path]::GetExtension($PSCommandPath) -eq '.ps1') {
        $psScriptPath = $PSCommandPath
    } else {
        $psScriptPath = [System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName
    }
    return $psScriptPath
}
$NewPSCommandPath = Get-PSScriptPath
$scriptName = Split-Path -Path $NewPSCommandPath -Leaf
$host.ui.RawUI.WindowTitle = "$scriptName"
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$NewPSCommandPath`"" -Verb RunAs
    exit
}
Clear-Host
$NewPSScriptRoot = if (-not $PSScriptRoot) { Split-Path -Parent (Convert-Path ([environment]::GetCommandLineArgs()[0])) } else { $PSScriptRoot }
$NewPSScriptRoot | Out-Null
$NewPSCommandPath = Get-PSScriptPath
$scriptName = Split-Path -Path $NewPSCommandPath -Leaf
$DossierTacheSurHome = "$env:USERPROFILE\Documents\1.Scripts"

if (!(Test-Path -Path "$DossierTacheSurHome\$scriptName")) {
    Get-Content "$NewPSCommandPath" | Add-Content -Path "$DossierTacheSurHome\$scriptName" -Force
}

$NameAppTask = "$scriptName"
try {
    $existingProperty = Get-ScheduledTask -TaskName "$NameAppTask" -ErrorAction Stop
}
catch {
    Write-Output "La Tache '$NameAppTask' n'existe pas."
    $existingProperty = $null
}
if ($null -eq $existingProperty){
    $PathApp = "$DossierTacheSurHome\$scriptName"
    if ($scriptName -like "*.ps1"){
        $A = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File $PathApp"
    } else {
        $A = New-ScheduledTaskAction -Execute "$PathApp"
    }
    $NameAppTask = "$scriptName"
    $DossierTacheSurHome = "$env:USERPROFILE\Documents\1.Scripts\$scriptName"
    $AdministrateurOuAdministrator = (Get-LocalGroup | Where-Object { $_.Name -match "Adminis*" } |     Select-Object -First 1).Name
    $scriptName = Split-Path -Path $NewPSCommandPath -Leaf
    $GroupIdFrench = "BUILTIN\$AdministrateurOuAdministrator"
    $PathApp = "$DossierTacheSurHome\$scriptName"
    $P = New-ScheduledTaskPrincipal -GroupId "$GroupIdFrench" -RunLevel Highest
    $S = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit 0
    $D = New-ScheduledTask -Action $A -Principal $P -Settings $S
    Register-ScheduledTask "$NameAppTask" -InputObject $D -TaskPath "\NonoOs"
    }
    Add-Type -AssemblyName System.Windows.Forms

    # Create a form
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Choix de la source audio"
    $form.Size = New-Object System.Drawing.Size(225, 175)
    $form.StartPosition = "CenterScreen"
    
    # Create a label
    $label = New-Object System.Windows.Forms.Label
    $label.Location = New-Object System.Drawing.Point(10, 20)
    $label.Size = New-Object System.Drawing.Size(280, 20)
    $label.Text = "Choisissez la source audio :"
    
    # Create buttons for each audio device
    $button1 = New-Object System.Windows.Forms.Button
    $button1.Location = New-Object System.Drawing.Point(30, 50)
    $button1.Size = New-Object System.Drawing.Size(150, 30)
    $button1.Text = "Headphones"
    $button1.Add_Click({
        $form.Tag = "Headphones"
        $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Close()
    })
    
    $button2 = New-Object System.Windows.Forms.Button
    $button2.Location = New-Object System.Drawing.Point(30, 90)
    $button2.Size = New-Object System.Drawing.Size(150, 30)
    $button2.Text = "ROG PG278QR"
    $button2.Add_Click({
        $form.Tag = "ROG PG278QR"
        $form.DialogResult = [System.Windows.Forms.DialogResult]::OK
        $form.Close()
    })
    
    # Add controls to the form
    $form.Controls.Add($label)
    $form.Controls.Add($button1)
    $form.Controls.Add($button2)
    
    # Show the form
    $result = $form.ShowDialog()
    
    # Check the selected device and set the default audio device accordingly
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $selectedDevice = $form.Tag
        if ($selectedDevice -eq "Headphones") {
            nircmd setdefaultsounddevice "Headphones"
            Write-Host "Headphones d�fini comme p�riph�rique audio par d�faut."
        } elseif ($selectedDevice -eq "ROG PG278QR") {
            nircmd setdefaultsounddevice "ROG PG278QR"
            Write-Host "ROG PG278QR d�fini comme p�riph�rique audio par d�faut."
        }
    }
    
