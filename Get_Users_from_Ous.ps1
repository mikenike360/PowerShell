$usersou = <THE OU YOU WANT TO GET USERS FROM>

foreach($user in $usersou){
        Get-ADGroupMember -Identity "<GROUP NAME>" 
    }
