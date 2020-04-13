##Delete user profiles older than 6 months##
$limit = (Get-Date).AddDays(-180)
$path = "C:\Users\"

$oldProfiles = Get-ChildItem -Exclude *.ini, Administrator, Administrator.FCN, "All Users", Default, "Default User", Public, !*, *admin, .NET* -Path $path -Force `
| Where-Object {$_.LastWriteTime -lt $limit} `
| Select-Object -ExpandProperty Name
$oldProfiles

foreach($user in $oldProfiles){
Get-CimInstance -ClassName Win32_UserProfile `
| Where-Object {$_.LocalPath.split('')[-1] -eq "C:\users\$user"} # | Remove-CimInstance
}

##uncomment the last line to actually remove the profiles
