function Get-AzdoAPIURL {
    [CmdletBinding()]
    param(

       [string]$profilename,
       [string]$area,
       [string]$resource,
       [string]$id,
       [string]$subdomain,
       [string]$projectname,
       [string]$version
    )

    process {
        
       $profile = Get-AzdoAPIToolsProfile -profilename $profilename
       $subdomain = $profile.Organization
       $baseUrl = If ([string]::IsNullOrWhiteSpace($profile.collectionUrl)) {'dev.azure.com'} Else {$profile.collectionurl}
       
       $sb = New-Object System.Text.StringBuilder
 
       $sb.Append('https://') | Out-Null
       if($area -eq 'Release'){
          $sb.Append('vsrm.') | Out-Null
       }
       $sb.Append($baseUrl) | Out-Null
       $sb.Append("/$subdomain") | Out-Null
       if ($projectname) {
         $sb.Append("/$projectname") | Out-Null
       }
       $sb.Append("/_apis") | Out-Null
 
       if ($area) {
          $sb.Append("/$area") | Out-Null
       }
 
       if ($resource) {
          $sb.Append("/$resource") | Out-Null
       }
 
       if ($id) {
          $sb.Append("/$id") | Out-Null
       }
 
       if ($version) {
          $sb.Append("?api-version=$version") | Out-Null
       }
 
       $url = $sb.ToString()
 
       return $url
    }
 }