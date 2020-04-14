$person = @{
    username=''
    first_name=''
    last_name=''
    password=''
    email=''
    ###etc.....
}
$json = $person | ConvertTo-Json
$json
pause

$response = Invoke-RestMethod '<URI>' -Method Post -Body $json -ContentType 'application/json'
