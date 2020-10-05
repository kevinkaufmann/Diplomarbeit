#GPO wird erstellt und verlinkt
#Skript auf dem Server TDN-FS-025 ausführen
$GPOLocation= 'F:\Share\GPO\gpo'
$GPO = "GPO_U_Netzlaufwerke"
$GPOID = "3E096082-E97C-44EA-92DF-588F9BB285F1"
$Target = "OU=AADDC Users,DC=tonazzidemo,DC=onmicrosoft,DC=com"

cd $GPOLocation

New-GPO -Name $GPO

Import-GPO -BackupId $GPOID -TargetName $GPO -Path $GPOLocation

New-GPLink -Target $Target -Name $GPO -LinkEnabled Yes -Enforced Yes -Order 1