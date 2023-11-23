<# :
    @echo off
    setlocal
    if not "%1"=="am_admin" (
    powershell -Command "Start-Process -Verb RunAs -FilePath '%0' -ArgumentList 'am_admin'"
    exit /b)
    set "dirPath=%TEMP%\NonoOS"
    if exist "%dirPath%" (
    rd /s /q  "%dirPath%" 2>nul
    )
    mkdir "%dirPath%"
    if not exist "%dirPath%\Menus" (
    mkdir "%dirPath%\Menus"
    )
    powershell /NoLogo /NoProfile /Command "(New-Object Net.WebClient).DownloadFile('https://github.com/ardelsaut/75c9b4a9-0012-453d-9e44-e84a458c035c/zipball/master/', '%dirPath%\base.zip')"
    powershell /nologo /noprofile /command ^
        "&{[ScriptBlock]::Create((cat """%~f0""") -join [Char[]]10).Invoke(@(&{$args}%*))}"
    exit /b
#>

$inputString = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$username = Split-Path -Path $inputString -Leaf
Expand-Archive -Path "C:\Users\$username\AppData\Local\Temp\NonoOS\base.zip" -DestinationPath "C:\Users\$username\AppData\Local\Temp\NonoOS\test"
Remove-Item -Path "C:\Users\$username\AppData\Local\Temp\NonoOS\base.zip" -Force

Copy-Item -Path "C:\Users\$username\AppData\Local\Temp\NonoOS\test\ardelsaut-75c9b4a9-0012-453d-9e44-e84a458c035c-eb3b5d0\*" -Destination "C:\Users\$username\AppData\Local\Temp\NonoOS\Menus" -Force -Recurse

Clear-Host
Write-Host "Veuillez choisir le(s) script(s) a executer..." -ForegroundColor Cyan
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Speech
do {
    $f = New-Object System.Windows.Forms.OpenFileDialog
    $test = Resolve-Path -Path "C:\Users\$username\AppData\Local\Temp\NonoOS\Menus"
    $f.InitialDirectory = $test
    $f.Filter = "Fichiers Powershell(*.ps1)|*.ps1;|Tous les Fichiers (*.*)|*.*"
    $f.Multiselect = $true
    $result = $f.ShowDialog()
    if ($result -eq [System.Windows.Forms.DialogResult]::OK -and $f.Multiselect) {
        foreach ($p in $f.FileNames) {
            Clear-Host
            Write-Host "Lancement du script: $p" -ForegroundColor Yellow
            Start-Process powershell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File $p -WindowStyle Normal" -NoNewWindow
            Write-Host "$p a ete execute." -ForegroundColor Yellow  -BackgroundColor DarkGreen
            $synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
            $synth.SelectVoice("Microsoft Zira Desktop")
            $synth.Rate = 1
            $synth.Volume = 100
            $synth.Speak("executed!")
        }
    }
} while ($result -eq [System.Windows.Forms.DialogResult]::OK -and $f.Multiselect)

