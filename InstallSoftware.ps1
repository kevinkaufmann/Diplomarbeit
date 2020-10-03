#Default Software wird Installiert
$Softwaredownload = "F:\Share\Software"

cd $Softwaredownload

Write-Host "PDF 24 wird installiert"
Start-Process -FilePath "$Softwaredownload\pdf24-latest.msi" -ArgumentList "/quiet"
Start-Sleep -s 35

Write-Host "Firefox wird installiert"
Start-Process -FilePath "$Softwaredownload\firefox-latest.exe" -ArgumentList "/S"
Start-Sleep -s 35

Write-Host "Microsoft Edge wird installiert"
Start-Process -FilePath "$Softwaredownload\msedge-latest.msi" -ArgumentList "/quiet"
Start-Sleep -s 35

Write-Host "Software erfolgreich installiert"

