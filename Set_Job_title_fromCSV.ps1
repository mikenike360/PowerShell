$data=Import-Csv "C:\titles.csv"

ForEach ($user in $data)
    {
    
    $username = $user.Username
    $title = $user.title
    $aduser = Get-ADUser -filter {SamAccountName -eq $username}


        try{
    
                Set-ADUser $user.Username -Replace @{title=$user.title}
                Write-Host "$($aduser.name) was set with a new job title: $($user.title)"
            }

        catch{
                write-warning "Could not set $($aduser.name) with their new job title: $($user.role)"}


}
