Get-Disk | Where-Object PartitionStyle –Eq 'RAW' | Initialize-Disk

New-Partition –DiskNumber 2 -AssignDriveLetter –UseMaximumSize

New-Partition –DiskNumber 2 -DriveLetter F –UseMaximumSize

Format-Volume -DriveLetter F -FileSystem NTFS -Confirm:$false

mkdir F:\Share
New-SmbShare -Name "Share" -Path "F:\Share" -ChangeAccess "Users" -FullAccess "Administrators","tonazzidemo.onmicrosoft.com\AAD DC Administrators"
