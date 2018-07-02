 Connect-AzureAD



$AppId = 'INSERT-APPLICATION-ID-HERE'


$DisplayName = 'INSERT-APPLICATION-DISPLAY-NAME-HERE'


$g = Get-AzureADGroup | ? {$_.DisplayName -eq 'AdminAgents'}


Get-AzureADGroupMember -ObjectId $g.ObjectId


$s = Get-AzureADServicePrincipal -All $true  | ? {$_.AppId -eq $AppId}



if ($s -eq $null) { $s = New-AzureADServicePrincipal -AppId $AppId -DisplayName $DisplayName }


Add-AzureADGroupMember -ObjectId $g.ObjectId -RefObjectId $s.ObjectId 
