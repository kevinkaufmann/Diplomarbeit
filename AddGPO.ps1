#GPO wird erstellt und verlinkt
$GPOLocation= 'F:\Share\GPO\gpo'
$GPO = "GPO_U_Netzlaufwerke"
$GPOID = "3E096082-E97C-44EA-92DF-588F9BB285F1"
$Target = "OU=AADDC Users,DC=tdncloud,DC=onmicrosoft,DC=com"

cd $GPOLocation

New-GPO -Name $GPO

Import-GPO -BackupId $GPOID -TargetName $GPO -Path $GPOLocation

New-GPLink -Target $Target -Name $GPO -LinkEnabled Yes -Enforced Yes -Order 1

#Default Software wird Installiert
$Softwaredownload = "F:\Share\Software"

cd $Softwaredownload

Start-Process -FilePath "$Softwaredownload\msedge-latest.msi" -ArgumentList "/quiet"

Start-Process -FilePath "$Softwaredownload\firefox-latest.exe" -ArgumentList "/S"

Start-Process -FilePath "$Softwaredownload\pdf24-latest.msi" -ArgumentList "/quiet"

