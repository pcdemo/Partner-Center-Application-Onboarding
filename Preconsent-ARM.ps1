# Pre-consent script (ARM)

#Install modules if needed
# Install-Module AzureRM.Resources
# Install-Module AzureAD

# login with Partner Center account with Global Admin role 
Login-AzureRMAccount


#web application name and App Id
$AppId = 'app_id_of_the_application'
$DisplayName = 'display_name_of_application'

# obtain reference to AdminAgent group
$g = Get-AzureRmADGroup | ? {$_.DisplayName -eq 'AdminAgents'}

#Check who is in the AdminAgent group currently - last column = ServicePrincipal identifies applications
Get-AzureRmADGroupMember -GroupObjectId $g.Id

# if service princial for application is not listed add its Service Principal to the AdminAgent group

# Get Service Principal for application
$s = Get-AzureRmADServicePrincipal | ? {$_.ApplicationId -eq $AppId}
if ($s -eq $null) { $s = New-AzureRmADServicePrincipal -ApplicationId $AppId -DisplayName $DisplayName }

# we have to authenticate again for this Graph commandlet 
Connect-AzureAD
#Add the Service Principal of the application to the AdminAgent group
Add-AzureADGroupMember -ObjectId $g.Id -RefObjectId $s.Id


#Confirm the service principal is added to group and appears in the list
Get-AzureRmADGroupMember -GroupObjectId $g.Id

# The service principal for application can be removed if required with
#Remove-AzureADGroupMember -ObjectId $g.Id -MemberId $s.Id

