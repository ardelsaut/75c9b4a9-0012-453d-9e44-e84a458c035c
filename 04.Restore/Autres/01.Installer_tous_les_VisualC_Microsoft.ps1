$FichierArchive = "$env:TEMP\NonoOS\Menus\04.Restore\Autres"
Expand-Archive -Path "$FichierArchive\VisualC.zip" -DestinationPath "$FichierArchive"

cmd /c "$FichierArchive\VisualC\install_all.bat"