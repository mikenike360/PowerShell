##Must run this from the target computer

clear-host

$computer = $env:COMPUTERNAME


Ping.exe -t <IP or FQDN of host to ping> | ForEach {"{0} - {1}" -f (Get-Date),$_} | Out-File (<SHARED LOCATION TO SAVE LOGS" + $computer + "_ping_log.txt")
