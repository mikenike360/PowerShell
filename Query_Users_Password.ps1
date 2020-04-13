$user = Read-Host "What is the user's username?"

Get-ADUser -Identity $user -Properties * | Select-Object Password*, LastLog* | format-list
