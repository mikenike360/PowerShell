###
# Account unlocker and password reset tool + other stuff as we add :)
# Written by Michael Venema v1.1
#
###

do{
    Clear-Host
    Write-Host "
    #######################################
    #  Welcome to the FCN Help Desk Tool! #
    #                                     #
    #    1: Unlock a user's account       #
    #                                     #
    #    2: Reset a user's password       #
    #                                     #
    #    3: Resolve a Computer Name       #
    #                                     #
    #######################################
    
    " -ForegroundColor Green
    
    ##ask what option to choose
    Write-host "What would you like to do? (Press 9 to Quit): " -Foregroundcolor Green -Nonewline
    $selection = Read-Host

    ##Begin powershell switch selection using input from above
    switch ($selection){
    
        ##Begin unlock user switch
        '1'{
            Try{
                $user = Get-ADUser -Filter * -Properties LockedOut | Where-Object {$_.LockedOut -eq "True"}`
                | Select-Object Name,SamAccountName | Out-GridView -PassThru -ErrorAction Stop  
                $user = $user | Select-Object -ExpandProperty SamAccountName
                Unlock-ADAccount -Identity $user
            }
            Catch
            {
                Write-host "There are currently no users with a locked Account" -ForegroundColor Red
            pause
        }
        }

        ##Begin password reset switch
        '2'{
            Write-Host "Please enter a user name to reset the password: " -ForegroundColor Green -Nonewline
            $userName = Read-Host 

            Try{
                Set-ADAccountPassword -Identity $userName -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "<TEMP PASSWORD>" -Force) -ErrorAction Stop
                Set-ADUser -Identity $userName -ChangePasswordAtLogon $true

            }Catch{
                Write-Host "That Username does not exist! Please double check your spelling!" -ForegroundColor Red
            }
        }

        ##Begin DNS resolve switch
        '3'{
            Write-Host "What is the computer number you want to resolve? " -ForegroundColor Green -NoNewline
            $compNum = Read-Host 

            Try{
                Clear-DnsClientCache -ErrorAction Stop
                Resolve-DnsName -name $compNum -ErrorAction Stop | Out-Host
                pause
            }Catch{Write-Host "That computer number does not exist or does not have a DNS entry" -ForegroundColor Red
            pause}
        }



    }
    ##End of while loop
}while($selection -ne 9)
