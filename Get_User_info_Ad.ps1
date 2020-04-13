$ouSearchBase = <OU THAT YOU WANT TO SEARCH>

$ouSearchBase | ForEach-Object{

Get-ADUser -filter "Name -like '*'" -SearchBase $_ -Properties  * }`
| select SamAccountName, GivenName, Surname, Title, Department, EmployeeNumber, manager, LastLogonDate `
| export-csv C:\userpasswordinfo.csv -Append
