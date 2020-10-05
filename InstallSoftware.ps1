#Default Software wird Installiert
#Skritp auf dem Server "TDN-WVD-0" ausführen
$Softwaredownload = "S:\Software"

cd $Softwaredownload

Write-Host "PDF 24 wird installiert"
Start-Process -FilePath "$Softwaredownload\pdf24-latest.msi" -ArgumentList "/passive"

Write-Host "Firefox wird installiert"
Start-Process -FilePath "$Softwaredownload\firefox-latest.exe" -ArgumentList "/S"

Write-Host "Microsoft Edge wird installiert"
Start-Process -FilePath "$Softwaredownload\msedge-latest.msi" -ArgumentList "/passive"