#####
#Add/Remove Licenses for office 365 users
#Written by :Michael Venema
#Version 1.1 - added switch statement instead of if statements to produce better output in console
####
import-module MSOnline
#Connect-MSOLService
Clear-Host
do{

Write-Host "
######################################################
# Welcome to the Office 365 License Tool!            #
# Written by: Michael Venema v1.0                    #
#                                                    #
# Note: Uncomment line 7 to connect to MS online     #
# You may need to install the Office 365 MFA Plugin! #
######################################################
#                                                                                    
#    1: Check license counts                                                         
#
#    2: Add licenses via C:\Scripts\users_add_license.csv
#
#    3: Remove Licenses via C:\Scripts\users_remove_license.csv
#
#    4: Create a list of licensed users. (Make sure to change the Match statement)
#
#
#" -ForegroundColor Green

Write-host "What would you like to do? (Press 9 to Quit): " -Foregroundcolor Red -Nonewline
$selection = Read-Host 
switch ($selection){

'1'{
    Clear-Host
    Get-MsolAccountSku | Out-Host
    break
    }


'2'{
    Clear-Host
    $users = import-csv "C:\Scripts\users_add_license.csv" -delimiter ","
    foreach ($user in $users)
    {$upn=$user.UserPrincipalName
    $SKU=$user.SKU
    Write-host "Adding $SKU to $upn"
    Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU
    }
    break
    }


'3'{
    Clear-Host
    $oldUsers = Import-Csv "C:\Scripts\users_remove_license.csv" -Delimiter ","
    foreach ($user in $oldUsers)
    {$upn=$user.UserPrincipalName
    $SKU=$user.SKU
    Write-Host "Removing $SKU from $upn"
    Set-MsolUserLicense -UserPrincipalName $upn -RemoveLicenses $SKU
    }
    break
    }


    ##Change the string after -match to search for a certain license type and find licensed users

'4'{
    Get-MsolUser | Where-Object {($_.licenses).AccountSkuId -match "TEAMS_EXPLORATORY"} | out-file C:\Scripts\out.csv
    break
    }



                    }#End of switch loop

                      
                }while($selection -ne '9')
