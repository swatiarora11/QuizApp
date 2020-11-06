<#
    this script can be used to control visibility of specified list on a given sharepoint online site

    use sharepoint online management shell to run this script
#>
param (
    # admin user name
    [string]$admin = '',
    
    # site url
    [string]$site = '',

    # list name
    [string]$list = '',

    # hidden
    [boolean]$hidden = ''
)

$userName= $admin
$password =Read-Host -Prompt "Enter Password" -AsSecureString 
 
#Setup Credentials to connect
$credentials = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($userName,$password)
 
function ShowHideList($siteUrl, $listName, $showHideValue)
{
    #Set up the context
    $context = New-Object Microsoft.SharePoint.Client.ClientContext($siteUrl)
    $context.Credentials = $credentials
 
    #Get the List
    $list = $context.Web.Lists.GetByTitle($listName)
    $list.Hidden = $showHideValue
    $list.Update()
    $context.ExecuteQuery()
    if ($showHideValue -eq $true)
    {
        Write-Host "$listName hidden successfully!"
    }else{
        Write-Host "$listName enabled/shown successfully!"
    }
}

ShowHideList $site $list $hidden