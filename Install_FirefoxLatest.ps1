# Download Mozilla Firefox Latest

$Destination= 'C:\_Temp'

New-Item -ItemType Directory -Force -Path $Destination
cd $Destination

if (Test-Path firefox-latest.exe -PathType leaf) {
    Write-Host "Mozilla Firefox Latest Exists In Folder: firefox-latest.exe"
}
else {
    Write-Host ">> Downloading Latest Version of Mozilla Firefox"
    Invoke-WebRequest 'https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=de' -OutFile firefox-latest.exe
    Write-Host ">> Download Complete"
}

Write-Host "++ Executing Firefox Installer..."
Start-Process -FilePath "$Destination\firefox-latest.exe" -ArgumentList "/S"

Start-Sleep -s 35

cd..
Remove-Item –path $Destination -Recurse