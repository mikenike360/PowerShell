###Remote User Activity###
###Written by Michael Venema###

Clear-Host

Write-host "
###############################################
Welcome to the Remote User activity reporter
Please read before running the script. You must
Make sure that you have exported a CSV file from
Citrix director and name it citrix.csv
and place it on C:\Scripts\
################################################
" -ForegroundColor Red
""
Pause

$data = Import-csv -Path "C:\Scripts\citrix.csv" 
$export = "C:\Scripts\remote_users.csv"


Write-Host "Grabbing Remote users from the CSV file please wait...."
""
$data | Where-Object {($_.Name -like "<USERNAME>") -or
           ($_.Name -like "<USERNAME>") -or
           ($_.Name -like "<USERNAME>") -or
           ($_.Name -like "<USERNAME>")} | `
      Export-Csv $export -NoTypeInformation

$filtered = "C:\Scripts\remote_users_filtered.csv"

Get-Content $export | Select-Object -Skip 1 `
| ConvertFrom-Csv  -Header 'Name', 'Machine', 'Group', 'Start', 'End', 'Duration', 'Department'`
| Export-Csv $filtered -NoTypeInformation



$users = Import-Csv $filtered -Delimiter ","

foreach($user in $users){
        $name = $user.Name
        Write-Host "Parsing $name and adding to export"
        $department = Get-ADUser -Identity $name -Properties Department | Select-Object -ExpandProperty Department
        $RowIndex = [array]::IndexOf($users.Department, " ")
        $user[$RowIndex].Department = $department
}


$file = "C:\Scripts\citrix_final_export.csv"


$Users | Export-csv $file -NoTypeInformation

Remove-Item $filtered
Remove-Item $export
