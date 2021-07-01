function Get-AzdoAPIToolsConfigDetails {
    param (
        # New Switch
        [Parameter(mandatory=$false)]
        [switch]
        $new
    )

    $profilename = Read-Host -prompt "Please provide an name / alias for the organization you want to add"
    $organization = Read-Host -prompt "Please provide the organization name for the Azure DevOps instance you want to connect to (https://dev.azure.com/<organizationname>)"
    $pat = Read-Host -prompt "Please provide a valid PAT string you want to add for $organization" -AsSecureString
    $collectionUrl = Read-Host -prompt "Optional: Please provide the collection url if the instance of Azure DevOps is on premisses(tfs.yourlocalserver/tfs). The protocol is not needed" 
    $pat = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pat))
    $encodedpat = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes("basic:$pat"))
    
    $JSONDetailConstruct = @"
{
            "profilename": "$profilename",
            "collectionUrl": "$collectionUrl",
            "Organization": "$organization",
            "pat": "$encodedpat"
        }
"@
    $JSONFULL = @"
{
    "profiles":[
        $JSONDetailConstruct
    ]
}
"@

    if ($profilename -and $organization -and $pat) {
        if ($new.IsPresent) {
            $return = $JSONFULL
        }else{
            $return = $JSONDetailConstruct
        }
    }else{
        Write-error "one or more questions were not answered. please retry"
    }

    Return $return

}