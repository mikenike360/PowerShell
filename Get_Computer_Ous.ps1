#Set the $computer variable to the path of the text file that holds the computer names
$computer = Get-Content -Path C:\Scripts\Computer.txt

#creates a foreach loop that parses through each line in the text file
#runs the get-adcomputer cmdlet that pull the object locations select that and places it into the pipeline and then exports to a csv that append each new line
foreach($_ in $computer){

Get-ADComputer -Filter "name -like '$_'" -Properties DistinguishedName | Select DistinguishedName | Export-Csv C:\Scripts\ComputerLocations.csv -Append}
