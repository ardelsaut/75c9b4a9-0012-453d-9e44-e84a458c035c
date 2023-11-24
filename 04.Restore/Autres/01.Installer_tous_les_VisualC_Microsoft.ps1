$FichierArchive = "$env:TEMP\NonoOS\Menus\04.Restore\Autres"
Expand-Archive -Path "$FichierArchive\4.VisualC.zip" -DestinationPath "$FichierArchive"

cmd /c "$FichierArchive\4.VisualC\install_all.bat"