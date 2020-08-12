########################################
# LAPS PWD Checker v1.0
# Written By: Michael Venema
# Requires the LAPs powershell module
########################################

$domain = Get-ADDomain | Select-Object DistinguishedName #Get the DN name for your domain controller

$computers = Get-ADComputer -SearchBase $domain.DistinguishedName -Filter * -Properties ComputerName #Grabs the names of all the computers in the domain

foreach ($computer in $computers){ #Loops through each computer and checks if it has a LAPS password set. If it does it will be displayed in the console

    Get-AdmPwdPassword -ComputerName $computer | Select-Object ComputerName,Password,DistinguishedName `
    | Where-Object {$_.Password -ne $null}
}
