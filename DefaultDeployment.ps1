###################################################################################
#Disk wird initialisiert und formatiert
Get-Disk | Where-Object PartitionStyle –Eq 'RAW' | Initialize-Disk

New-Partition –DiskNumber 2 -AssignDriveLetter –UseMaximumSize

New-Partition –DiskNumber 2 -DriveLetter F –UseMaximumSize

Format-Volume -DriveLetter F -FileSystem NTFS -Confirm:$false

#Share auf Disk wird eingerichtet und Berechtigungen erteilt
$Share = "F:\Share"
mkdir $Share
New-SmbShare -Name "Share" -Path $Share -ChangeAccess "Users" -FullAccess "Administrators","tonazzidemo.onmicrosoft.com\AAD DC Administrators"

###################################################################################
#Windows Features für die Verwaltung vom AD und der GPO werden installiert
ADD-WindowsFeature -Name GPMC
ADD-WindowsFeature -Name RSAT-Role-Tools

###################################################################################
#Regionsanpassungen werden gemacht
Set-WinHomeLocation 223 
Set-WinUserLanguageList -LanguageList de-CH -Force
Set-WinSystemLocale -SystemLocale de-DE
Set-Culture -CultureInfo de-CH
Set-TimeZone -Id "W. Europe Standard Time" -PassThru
Set-Culture -CultureInfo de-CH


####################################################################################
#Gruppenrichtlinien Backups werden heruntergeladen und extrahiert
$Url = 'https://raw.githubusercontent.com/kevinkaufmann/Diplomarbeit/master/gpo.zip'
$ZipFile = 'F:\Share\GPO\' + $(Split-Path -Path $Url -Leaf) 
$Destination = "F:\Share\GPO"

New-Item -ItemType Directory -Force -Path $Destination
cd $Destination
Invoke-WebRequest -Uri $Url -OutFile $ZipFile

Expand-Archive -LiteralPath $ZipFile -DestinationPath $Destination
Start-Process $Destination

Remove-Item –path $ZipFile

###################################################################################
#Default Software wird heruntergeladen
$Softwaredownload = "F:\Share\Software"

New-Item -ItemType Directory -Force -Path $Softwaredownload
cd $Softwaredownload

#Download EDGE
if (Test-Path msedge-latest.msi -PathType leaf) {
    Write-Host "Microsoft Edge Latest Exists In Folder: msedge-latest.msi"
}
else {
    Write-Host ">> Downloading Latest Version of Microsoft Edge"
    Invoke-WebRequest 'http://dl.delivery.mp.microsoft.com/filestreamingservice/files/8fefa6a6-bf4b-45b1-8051-791dbf60ecd1/MicrosoftEdgeEnterpriseX64.msi' -OutFile msedge-latest.msi
    Write-Host ">> Download Complete"
}
#Download Firefox
if (Test-Path firefox-latest.exe -PathType leaf) {
    Write-Host "Mozilla Firefox Latest Exists In Folder: firefox-latest.exe"
}
else {
    Write-Host ">> Downloading Latest Version of Mozilla Firefox"
    Invoke-WebRequest 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=de' -OutFile firefox-latest.exe
    Write-Host ">> Download Complete"
}

#Download PDF24
if (Test-Path pdf24-latest.msi -PathType leaf) {
    Write-Host "PDF24 Reader Latest Exists In Folder: pdf24-latest.msi"
}
else {
    Write-Host ">> Downloading Latest Version of PDF24 Reader"
    Invoke-WebRequest 'https://stx.pdf24.org/products/pdf-creator/download/pdf24-creator-9.2.2.msi' -OutFile pdf24-latest.msi
    Write-Host ">> Download Complete"
}

####################################################################################
#Vorbereitete Skripts werden auf dem Fileserver abgelegt
$Deploymentfolder = "F:\Share\Deployment-Skripts"
New-Item -ItemType Directory -Force -Path $Deploymentfolder
Copy-Item C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\*\Downloads\*\AddGPO.ps1 $Deploymentfolder
Copy-Item C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\*\Downloads\*\InstallSoftware.ps1 $Deploymentfolder
Copy-Item C:\Packages\Plugins\Microsoft.Compute.CustomScriptExtension\*\Downloads\*\ChangeLocatonSettings.ps1 $Deploymentfolder