Clear-Host

Write-Host "Veuillez choisir le(s) script(s) a executer..." -ForegroundColor Cyan
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Speech
do {
    $f = New-Object System.Windows.Forms.OpenFileDialog
    $test = Resolve-Path -Path "$env:TEMP\NonoOS"
    $f.InitialDirectory = $test
    $f.Filter = "Fichiers Powershell(*.ps1)|*.ps1;|Tous les Fichiers (*.*)|*.*"
    $f.Multiselect = $true
    $result = $f.ShowDialog()
    $User32 = Add-Type -Debug:$False -MemberDefinition '[DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X,int Y, int cx, int cy, uint uFlags);' -Name "User32Functions" -namespace User32Functions -PassThru -ErrorAction SilentlyContinue
    [Void]$User32::SetWindowPos($hwnd, -1, 0, 0, 0, 0, 0x53)
    if ($result -eq [System.Windows.Forms.DialogResult]::OK -and $f.Multiselect) {
        foreach ($p in $f.FileNames) {
            Clear-Host
            Write-Host "Lancement du script: $p" -ForegroundColor Yellow
            & $ExePowershell -ExecutionPolicy Bypass -File "$p"
            Write-Host "$p a ete execute." -ForegroundColor Yellow  -BackgroundColor DarkGreen
            $synth = New-Object -TypeName System.Speech.Synthesis.SpeechSynthesizer
            $synth.SelectVoice("Microsoft Zira Desktop")
            $synth.Rate = 1
            $synth.Volume = 100
            $synth.Speak("executed!")
        }
    }
} while ($result -eq [System.Windows.Forms.DialogResult]::OK -and $f.Multiselect)
exit
