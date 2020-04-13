##############################################################################################
##                      Inventory Checker v1.4 (Added option to dump output to csv )        ##
##                      Written By: Michael Venema                                          ##
##                      Last Edit : 3/24/20                                                 ##
##                                                                                          ##
#############################################################################################

##Grabs a list of all AD computers and places them into an array
$adArray = Get-ADComputer -Filter * -Property Name `
-SearchBase "<YOUR OU>" `
| Select-Object -ExpandProperty Name

##Set the needed variables for a SQL connection 
$sqlServer = "<YOUR SQL SERVER>"
$avDataBase = "<ANTI VIRUS DEVICE DATABASE>"
$avQuery = "<YOUR QUERY TO GET THE DEVICES YOU WANT>"

##puts the results of the AV query into an array
$avArray = @(Invoke-Sqlcmd -ServerInstance $sqlServer -Database $avDataBase -Query $avQuery `
-Username "<YOUR SQL USERNAME>" -Password "<YOUR SQL PASSWORD>" -Verbose)

##Define Variables needed for the FDE query
$fdeQuery = "<YOUR ENCRYPTION QUERY>"
$fdeDataBase = "<ENCRYPTION DATABASE>"

##puts the result of the FDE query into an array
$fdeArray = @(Invoke-Sqlcmd -ServerInstance $sqlServer -Database $fdeDataBase -Query $fdeQuery `
-Username "<YOUR SQL USERNAME>" -Password "<YOUR SQL PASSWORD>" -Verbose)

##Define Variables needed for the HelpDesk Query
$hdQuery = "<YOUR HELP DESK QUERY>"
$hdDataBase = "<HELPDESK DATABASE>

##puts the result of the HelpDesk Query in an Array
$hdArray = @(Invoke-sqlcmd -ServerInstance $sqlServer -Database $hdDataBase -Query $hdQuery `
-Username "<YOUR SQL USERNAME>" -Password "<YOUR SQL PASSWORD>" -Verbose)

#creates a function to compare AD and AV
function adAndAv {
    $compareAdAv = Compare-Object -ReferenceObject $adArray -DifferenceObject $avArray.ItemArray
    $compareAdAv | ForEach-Object{
     if ($_.sideindicator -eq '<='){$_.sideindicator = "Device is in AD but not Trend AV"}
     if ($_.sideindicator -eq '=>'){$_.sideindicator = "Device is in Trend AV but not AD"}
}
    $compareAdAv | Select-Object @{l='Device';e={$_.InputObject}},@{l='Status';e={$_.sideindicator}}
}

#creates a function to compare AD and FDE
function adAndFde{
    $compareAdFde = Compare-Object -ReferenceObject $adArray -DifferenceObject $fdeArray.ItemArray
    $compareAdFde | ForEach-Object{
     if ($_.sideindicator -eq '<='){$_.sideindicator = "Device is in AD but not Trend FDE"}
     if ($_.sideindicator -eq '=>'){$_.sideindicator = "Device is in Trend FDE but not AD"}
}
    $compareAdFde | Select-Object @{l='Device';e={$_.InputObject}},@{l='Status';e={$_.sideindicator}}
}

#creates a function to compare AD and the Help Desk
function adAndHd{
    $compareAdHd = Compare-Object -ReferenceObject $adArray -DifferenceObject $hdArray.ItemArray
    $compareAdHd | ForEach-Object{
     if ($_.sideindicator -eq '<='){$_.sideindicator = "Device is in AD but not WebHelpDesk"}
     if ($_.sideindicator -eq '=>'){$_.sideindicator = "Device is in WebHelpDesk but not AD"}
}
    $compareAdHd | Select-Object @{l='Device';e={$_.InputObject}},@{l='Status';e={$_.sideindicator}}
}


Clear-Host
    Write-Output "
    #### Welcome to the Inventory Checker ####
    #
    #  Choose a database by number:
    #    
    #    1: Compare AD and AV devices
    #
    #    2: Compare AD and FDE devices
    #
    #    3: Compare AD and Help Desk devices
    #
    #    4: Export a CSV to C drive containing all DB comparisons
    #
    #    END: Exits the Inventory Checker                                         
    #"

$selection = Read-Host "What databases would you like to compare?"

##AD and AV comparison block
if ($selection -eq 1){
    Clear-Host
     Write-Host "Begin AD and AV Comparison"
    adAndAv
}

##AD and FDE comparison block
elseif ($selection -eq 2){
   Clear-Host
    Write-Host "Begin AD and FDE Comparison"
   adAndFde
}

##AD abd Helpdesk comparison block
elseif ($selection -eq 3){
   Clear-Host
    Write-Host "Begin AD and Help Desk Comparison"
   adAndHd  
}

##Add CSV export option
if ($selection -eq 4){
    Clear-Host
     Write-Host "Exporting all DB Comparisons to C drive"
     adAndAv | Export-Csv "C:\Inventory_Export.csv" -NoTypeInformation
     adAndFde | Export-Csv "C:\Inventory_Export.csv" -Append -NoTypeInformation
     adAndHd | Export-Csv "C:\Inventory_Export.csv" -Append -NoTypeInformation
}

##end block
elseif ($selection -like "END" -or "end") {
    Exit
    }
