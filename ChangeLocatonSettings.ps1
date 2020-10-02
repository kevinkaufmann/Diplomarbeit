Set-WinHomeLocation 223 
Set-WinUserLanguageList -LanguageList de-CH -Force
Set-WinSystemLocale -SystemLocale de-DE -Force
Set-Culture -CultureInfo de-CH
Set-TimeZone -Id "W. Europe Standard Time" -PassThru
Set-Culture -CultureInfo de-CH
DISM /online /Get-Intl

