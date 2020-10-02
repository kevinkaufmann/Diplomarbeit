ADD-WindowsFeature -Name GPMC
ADD-WindowsFeature -Name RSAT-Role-Tools

$Url2 = 'https://github.com/kevinkaufmann/Diplomarbeit/raw/master/gpo.zip' 
$Url = 'https://raw.githubusercontent.com/kevinkaufmann/Diplomarbeit/master/gpo.zip'
$ZipFile = 'C:\Git\' + $(Split-Path -Path $Url -Leaf) 
$Destination= 'C:\Git'
$GPOLocation= 'C:\Git\gpo\'
$GPO = "GPO_U_Netzlaufwerke"
$GPOID = "3E096082-E97C-44EA-92DF-588F9BB285F1"
$Target = "OU=AADDC Users,DC=tdncloud,DC=onmicrosoft,DC=com"

New-Item -ItemType Directory -Force -Path $Destination

Invoke-WebRequest -Uri $Url -OutFile $ZipFile

$ZipFile
$Destination
 
Expand-Archive -LiteralPath $ZipFile -DestinationPath $Destination
Start-Process $Destination

Remove-Item –path $ZipFile

New-GPO -Name $GPO

Import-GPO -BackupId $GPOID -TargetName $GPO -Path $GPOLocation

New-GPLink -Target $Target -Name $GPO -LinkEnabled Yes -Enforced Yes -Order 

#Remove-Item –path $Destination -Recurse