$aduser=Import-Csv "C:\import.csv"

ForEach ($user in $aduser){

    $first = $user.Firstname
    $last = $user.Lastname
    $username = $user.Username
    $empcode = $user.Employee_Code
 
   Get-ADUser -Filter {Samaccountname -eq $username}  | Set-ADUser -EmployeeNumber $empcode
   }

##Sets and employee code by matching on first and last name from an imported csv file 
