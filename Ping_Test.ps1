##Must run this from the target computer

clear-host

$computer = $env:COMPUTERNAME


Ping.exe -t 172.16.64.10 | ForEach {"{0} - {1}" -f (Get-Date),$_} | Out-File (<SHARED LOCATION TO SAVE LOGS" + $computer + "_ping_log.txt")
