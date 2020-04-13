Add-PSSnapin Citrix*
Import-Module Citrix* -Global

$domain = (Get-ADDomain).NetBIOSName
$user = Read-Host "What is the user's username that you would like to discconect?"

Write-Host "Pulling Session Information for"$domain\$user""

Get-BrokerSession -UserName "$domain\$user" | Stop-BrokerSession
