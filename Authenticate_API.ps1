$RESTAPIServer = '<URL OF API>'

$RESTAPIUser = "<USERNAME>"
$RESTAPIPassword = "<PASSWORD>"

$BaseAuthURL = "https://" + $RESTAPIServer + "/login"
$Header = @{"Authorization" = "Basic "+[System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($RESTAPIUser+":"+$RESTAPIPassword))}
$Type = "application/json"


Try 
{
$data = Invoke-RestMethod -Uri $BaseAuthURL -Headers $Header -Method Post -ContentType $Type
}
Catch 
{
$_.Exception.ToString()
$error[0] | Format-List -Force
}
