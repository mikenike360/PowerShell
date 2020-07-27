#Script prompts for group name and the OU search base. Make sure you use the full distinguished name for the OU!

$group = Read-Host "What group would you like to query?" 
$disOu = Read-Host "What OU would you like to query? Make sure to use the distingusihed name!!"

Get-ADGroupMember -Identity $group |
ForEach-Object {
    Get-ADUser -Filter "Name -eq '$($_.Name)'" -SearchBase $disOu | Select-Object Name
}
