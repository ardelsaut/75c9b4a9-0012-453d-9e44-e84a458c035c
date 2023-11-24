$cheminPs1 = "$env:USERPROFILE\Documents\1.Scripts\1.Nas\02.Nas.ps1"
if (Test-Path "$cheminPs1") {
    $DossierRaccourci = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    $NomFichier = (Get-Item "$cheminPs1").Name
    $cheminRaccourci = "$DossierRaccourci\$NomFichier.lnk"
    if (!(Test-Path "$cheminRaccourci")) {
        $shell = New-Object -ComObject WScript.Shell
        $raccourci = $shell.CreateShortcut($cheminRaccourci)
        $raccourci.TargetPath = $cheminPs1
        $raccourci.Save()
    }
}

$cheminPs1 = "$env:USERPROFILE\Documents\2.Applications\0.exe_Files\ChangeAudioDevice.exe"
if (Test-Path "$cheminPs1") {
    $DossierRaccourci = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    $NomFichier = (Get-Item "$cheminPs1").Name
    $cheminRaccourci = "$DossierRaccourci\$NomFichier.lnk"
    if (!(Test-Path "$cheminRaccourci")) {
        $shell = New-Object -ComObject WScript.Shell
        $raccourci = $shell.CreateShortcut($cheminRaccourci)
        $raccourci.TargetPath = $cheminPs1
        $raccourci.Save()
    }
}

$cheminPs1 = "$env:USERPROFILE\Documents\2.Applications\0.exe_Files\Shutdown_Poweroff_Computer.exe"
if (Test-Path "$cheminPs1") {
    $DossierRaccourci = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    $NomFichier = (Get-Item "$cheminPs1").Name
    $cheminRaccourci = "$DossierRaccourci\$NomFichier.lnk"
    if (!(Test-Path "$cheminRaccourci")) {
        $shell = New-Object -ComObject WScript.Shell
        $raccourci = $shell.CreateShortcut($cheminRaccourci)
        $raccourci.TargetPath = $cheminPs1
        $raccourci.Save()
    }
}

$cheminPs1 = "$env:USERPROFILE\Documents\2.Applications\0.exe_Files\sudo_reboot.exe"
if (Test-Path "$cheminPs1") {
    $DossierRaccourci = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    $NomFichier = (Get-Item "$cheminPs1").Name
    $cheminRaccourci = "$DossierRaccourci\$NomFichier.lnk"
    if (!(Test-Path "$cheminRaccourci")) {
        $shell = New-Object -ComObject WScript.Shell
        $raccourci = $shell.CreateShortcut($cheminRaccourci)
        $raccourci.TargetPath = $cheminPs1
        $raccourci.Save()
    }
}

$cheminPs1 = "$env:USERPROFILE\\Documents\Github\75c9b4a9-0012-453d-9e44-e84a458c035c\NonoOS.bat"
if (Test-Path "$cheminPs1") {
    $DossierRaccourci = "$env:APPDATA\Microsoft\Windows\Start Menu\Programs"
    $NomFichier = (Get-Item "$cheminPs1").Name
    $cheminRaccourci = "$DossierRaccourci\$NomFichier.lnk"
    if (!(Test-Path "$cheminRaccourci")) {
        $shell = New-Object -ComObject WScript.Shell
        $raccourci = $shell.CreateShortcut($cheminRaccourci)
        $raccourci.TargetPath = $cheminPs1
        $raccourci.Save()
    }
}



$shell = New-Object -ComObject Shell.Application
$folder = $shell.Namespace('C:\Users\Nono\AppData\Roaming\Microsoft\Windows\Start Menu\Programs')
$item = $folder.ParseName('NonoOS.bat.lnk')
$item.InvokeVerb('pin to start menu')
$shell = New-Object -ComObject Shell.Application
$folderPath = [System.IO.Path]::Combine($env:APPDATA, 'Microsoft\Windows\Start Menu\Programmes')
$folder = $shell.Namespace($folderPath)
$item = $folder.ParseName('NomDuProgramme.lnk')

$shell = New-Object –ComObject Shell.Application
$folder = $shell.Namespace('C:\Users\Nono\AppData\Roaming\Microsoft\Windows\Start Menu\Programs')
$item = $folder.Parsename("NonoOS.bat.lnk")
$verb = $item.Verbs() | Where-Object {$_.Name –eq 'Ajouter aux &Favoris'}
if ($verb) {
     $verb.DoIt()
}

# # Start Menu Show pins
# New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name Start_Layout -PropertyType DWord -Value 1 -Force
# if (!(Test-Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer")){
#     New-Item -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Force | Out-Null
# }
# if (!(Test-Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer")){
#     New-Item -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Force | Out-Null
# }
# New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -Value "1" -PropertyType Dword -Force | Out-Null
# New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "HideRecentlyAddedApps" -Value "1" -PropertyType Dword -Force | Out-Null
# New-ItemProperty -Path "HKCU:\Software\Policies\Microsoft\Windows\Explorer" -Name "ShowOrHideMostUsedApps" -Value "0" -PropertyType Dword -Force | Out-Null
# New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsHistory" -Value "1" -PropertyType Dword -Force | Out-Null
# New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" -Name "NoRecentDocsMenu" -Value "1" -PropertyType Dword -Force | Out-Null
# New-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "Start_TrackDocs" -Value "0" -PropertyType Dword -Force | Out-Null
# New-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value "0" -PropertyType Dword -Force | Out-Null
# New-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarDa" -Value "0" -PropertyType Dword -Force | Out-Null
# New-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value "0" -PropertyType Dword -Force | Out-Null
# New-ItemProperty "HKCU:\Software\Microsoft\Windows\CurrentVersion\Search" -Name "SearchboxTaskbarMode" -Value "0" -PropertyType Dword -Force | Out-Null

# #((New-Object -Com Shell.Application).NameSpace("shell:::{4234d49b-0245-4df3-b780-3893943456e1}").Items() | ?{$_.Name -eq "Microsoft Edge"}).Verbs() | ?{$_.Name.replace("&","") -match "Unpin from taskbar"} | %{$_.DoIt(); $exec = $true}
# ((New-Object -Com Shell.Application).NameSpace("shell:::{4234d49b-0245-4df3-b780-3893943456e1}").Items() | ?{$_.Name -eq "Microsoft Store"}).Verbs() | ?{$_.Name.replace("&","") -match "Unpin from taskbar"} | %{$_.DoIt(); $exec = $true}
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" -Name "DisableEdgeDesktopShortcutCreation" -Type Dword -Value "1" -Force


# Remove-Item "$env:LOCALAPPDATA\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState" -Recurse -Force -ErrorAction Ignore
# New-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy" -Name "LocalState" -ItemType "directory" -Force | Out-Null
# $HexString = "E27AE14B01FC4D1B9C00810BDE6E51854E5A5F47005BB1498A5C92AF9084F95E9BDB91E2EEDDD701300B000067DEFA31529529B3D32D8092A6EB66C8D5EADB19CF9B13518AAB93275D9CEEF37E62C3574C036F327D1110AB0977996D67A2F8FA897D7207BEE85586B8CE6AD4F9736AA2154E3DCC9D082996984B76F1C73067F124F92A41F2B2CA83EF35436670979556FAE85AB10EA16C932C3AECE1D45DA06D64BC42F4565AD0FCB8C63CDE7F6BB97ACE300198C3EACA3E1C974F547B1A7CF5B9C6A912448AB38A3BE2D6F0230A4A9AACC710C3E75088754CC2FB054B55B1D6ED7AD41EB8B0C9D4C274E87A525582F6CFBEAE5A904A1B0A3BA07939B79CAB4F1C3DF35BF88DE846E64555F0AEB47562C329206A9975664558849E0C251E8832D52B4FD7560347E5606AC882B9FC1F43C96922C0EA1927DF004A062BAD5AC5A4BE6BF2DB23158B2BAEEF8DE9E3A777910E82E5488A83E4D64B0D84440B98B35BC4A3438596145669904AB392CFD5F7E22F616747B84851481FE1FF41CA9A2534CCE7AFC45584370B4940DF30555536344249690F00C3A7E2552E352FE733C7ED2F80A29AD16937810AF805A444A344188C0CBDA51E5466BF45F2587508A69581CC2BCDAE06CB363658D94CD60569352FDA17AE7CDD785810F369B41F2D15930430A809567CC6C643FE7986CAD545EF3DB40CA6FA9220BFC7F65610AECB22799838B80DE73AF549923F8219FFAAD64780E2DB53133D73890294E77F9B0970484E86A050737724FF15281C1726D334D3C9A67A85A78AE33F55DB675DAA31C47A156C0F8212DCEE228537668F4BF898C0CB869B74C98DF7EFBE0130859E5156417A85CC634B86314FAB47FB9A8DFEAFA1AEFC5E599A3F744BA51E8E6823F80E1529187FA5A78420B1EC091FD93134A71A0A0F478341D9ABD2CEABD5444160023C9CAB0A5C2BAC97F55F1E98FD21F2CFF03D2D24E0C4642F4A8A6E7627BD143AFC1A6DAE697B286C941B5EAAF57D34D598317C97F7CA23544B219196661B73E9DD27EBFE204B43C98C241AB02D2AA3A4EE7B2B477FC5E31642AF613BF356DFBE8AD666CE93267A3D45FD40F83CABAA2F0AE2601C470D98AC4ABBCFA968882986297D06D81C1BE1EE8A0E64FB7543981B8E632809FBA7606BF518E8792EF4FBDC5CFC55690D8DF60812ECB2A39EB24B6F941C966DEF89E61E000D3F28CB6B260B17A53CE8EEFC371C98BBEE72DE915BA9023DC74EEE7895D60AC2D13B51E73EB37E0FB714BB259614F3F7CBECD66EBDAE52FCB01D778C413DE0ED739DEA7AE48543614B93D46F63D1076E3C7696863D8F64EAC7CAA7224FEB1A15E114358F379CA686AD7F09E75E2350F38A3B27F38D2DEFFB008B007371BD32E65B39FF6661DA237F277AC4A9C4DA5A1753250BBD3FA7ECD07E594C2014B5E26E06414B6588211CE439DAA2A352B017C196B4F20049DDBF2E4514E2CD7545E5AE22E877D5B6975D7FCDC61D49958258A093B05DB6D7C6457B9C260A420B1A15C6010B9C4AE68078E1B9592C97B47BFFE2C2F10A10129CC3B087041840091D2A6F5FDA1561E2F0315F8F0BF46204AA4E7C12DC819A1ABCDEB02400AA2FD46ECE2B8698C19F61ECA68232536A712BC858029D40FED5C20A051BCE6D316B03A97FE7051EE0C952A7EB9FD2F77D9FBE75022FF5D13B168BD0B004D9C803E8F8C5D8F25CB22ACC97D8EDE169E5D50FCD87444C2029F021D87807B4A04EF148EF1C814E2827FABBCDE9E042140E0D890CEDE88B21F9824956D8F18EF3A8AC85194248915F53AF26F70BC5FDC26E415936EAB0DD78398B725F5419E8DDFD46EE9A17A37087507F9D20358208A65366C4824518E75413FDE5F27FC5DD8132EFB4414A5BDDDA1D64593D86360062373FEE36F51ED56CA419FAD69751F76588995F9E2BE75ED13D2DED91EC1DED011752089716DD9C89DE21B8E52AD08CF1C463B0D79111200DF5269C646FBF0E3091A413CA70F6CA8F75BE257DB028329F7224023603C743AB204F8DAB5C273975FA93FBAAD84D0E4D72ABAC3A4E23D7236C848AD317E73E114C5B7438B8248C75B528E19E26D9BF908001A3214A137F24C74BC7D9910F858E47789FDFE52AB712AE758AE15C4D86ED3C23D4EB78C5ED94D8A5AB8AA93C43E18FC0CE418AC79DF945E81A58B70332A2C03C445436E8013E0B82AC59AF856C6A00812BCD3B6209449B6D008CA37D8A9210A61049350AD07F4E88FC7FBEC9FC64BC60C318912E36DBEA6D4058AF35CACD6E790C96B66EAE5966C47D3E1C4ACF42BF04D58FF363D20DBA61C9D32EBE433A45AFE02B41FD6FC91AE7157CCD7FACEC294623F825DE576F72A8245D2BC5D1D7C71B183166C8F0DAF9CF8ED6F1DAEBB0349D82E57BB81DB946128A5440235AD6222A294B27E97738D49F52170DE1B1B922C8C548215FD0D2980D7BA9B8F3133D9415BAB29670A5EDEC4858EB9D1A7E8FBD0296CB6D610BDD44A1A450EDEC61983152C237225F7AABABD482EB08328BC338D87BA1FE30864D9A97C20FA42CAEDF6359457C8BB26032A9728E819FFF9BF4F715469A0A4506A4CA1625E79CAE215683CDAADFB1E68ADC4987FF3FD7E9859CB40291478A4D2B281AEFEB97DC45C7F991311A68C2F173E2377709C355C6870DC4C14E5534120539C1DB0AD0D6E331D670581F6E352DCB3E34D61E6742F957FE9F39854A324E07C68A17BE9CB19446583EDDAAFD0E433A54F4E0854709BD47B24AC76DF75849B9D917FF2B0F4228C94EA01CF658430B2C18F6EEAB104B9A935C6FBFEA494190BF3446DCC8C8AAF62BA01F0BFB18E15503C27558DB70C48EFB0AEA0B600F985C904E9F244E2A08464AE980E1A8CC05F22C9D4C23D753FD5250D0E190CB0CAC71404CF52A8CCEC988DBA22F2164E203FB52064F38D8277764FECB0E2D811C307E4687CF6A245B2B89389D188E1F115EF2B36BA1BE63222A2C7E886A279B08ADF70109903F70EA1068137E72E894758614FE4BBAF333B8FC3EA98B149B3403FF8655FAAE1DF4877B5CDABC434B7336AB24C25A85246ADAA24DECB5A39F8FD7A5549F23F112244B7EE9E447D3226F2259428FDC0C3D6CD3A47B39092532B803FEBB6FFCC1ADF26C7857F04F294F16A9DA7DD851D4EC99BBCF853FD3435A256F47DD3CB9480365C2896A1D0E2314940968E4E3714723B4C1CDD368581FED307C8B279AE6FB8BB72EC0A093733E2D9CC6B43320766D3B43D3C554CA82EEEF7B09850D29B2F412DEF3D0BD9194CAE8113B3B38085C77C238CB8D15BF6D6AB42C193F4E2F27F8BEDABB2D6ADE9E486B6AFAFD8D5DBE3B7D7305790F96ECDCC2DD016C5B9B200CB72E6CF54D71F69A01CDE4E3A0A4C5A03627DECD491F215C1420EB07AB8FD2763FCFF5211EB964C82E69DA208BDFA76306D54642B117DCB9A92927CE2E633338D4EEA63B571349B8DA1D4B5523C4CA10308769E4F461ADD16DD5DFDB0E705187593DEF5CCCF659E48366462CC21D7930E1064234157A7A08E9C90927A37C5CF23D54C755002E4E657BB6E70D9B4BE7C468C19D6969FAE138EBF2C20DD3F5A0BC4C0E97D5BFDB8744A21396C44549242817BEAD5AE14FF602E69E75B87784DE5F30BE14106E8D8A081DC8CCCFBF93896E622F755F27E82A596DDCA3469A93ECB9E2E897BF0FCC063426DACDC3B1D81E1EFE6B639326CA43526CFAEDF9922EAC3204FEB84AAED781EE5516FA5B4DCAB85DB5FF33CEC454DAA375BDA5EEA7C871C310AEDC5BD6B220B59B901D377E22FFFE95FEDA28CE2CE33CAEB8541EE05E1B5650D776C4B2A246DB4613E2CC5D96A44D24AE662D848A7C9E3E922AFF0632B7B40505402956FABC5C3AAB55EEE29085046C127E8776CEFC1690B76EE99371AF9B1D7EF6F79E78325DD3BD8377E9B73B936C6F2611D0A1223A4D7C6CF3037922DD0686A701FF86761993F294D26E13A7BB8B1C61ACAF38D50334A88DABB3FA412B4FC79F6FBFD0D0A92301484FF1BD1CF3DC67780E4562E05CCA329CABA7CB2B77D9A707BDEE24B1E5E4ED6CC9D5A337908BE5303E477736C8A75051A8FBD4E3CB6360D8F0A992A48F333434D4AE712EC830BCB5EAA98788B6C76C"
# $Bytes = [byte[]]::new($HexString.Length / 2)
# For($i=0; $i -lt $HexString.Length; $i+=2){$Bytes[$i/2] = [convert]::ToByte($HexString.Substring($i, 2), 16)}
# Set-Content "$env:LOCALAPPDATA\Packages\Microsoft.Windows.StartMenuExperienceHost_cw5n1h2txyewy\LocalState\start.bin" -Value $Bytes -Encoding Byte










# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "ContentDeliveryAllowed" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "OemPreInstalledAppsEnabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEnabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "PreInstalledAppsEverEnabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SilentInstalledAppsEnabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338387Enabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338388Enabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-338389Enabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SubscribedContent-353698Enabled" -Type Dword -Value "0"
# Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" -Name "SystemPaneSuggestionsEnabled" -Type Dword -Value "0"
# If (!(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent")) {
#     New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Force | Out-Null
# }
# Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent" -Name "DisableWindowsConsumerFeatures" -Type Dword -Value "1"
