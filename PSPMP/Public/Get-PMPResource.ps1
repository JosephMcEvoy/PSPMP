<#
    .SYNOPSIS
     Gets resources from PMP.
    
    .DESCRIPTION
     Gets resources from PMP.
    
    .PARAMETER Server
     The server name and port where PMP is hosted. This is mandatory.
    
    .PARAMETER Token
     The PMP API Token. This is mandatory.

    .PARAMETER Resource
    The name of the resource. When this paramater is provided, the cmdlet will return all resources that 
    match the name provided.

    .EXAMPLE
    Get all PMP resources.
    Get-PMPResource -Server 'pmpserver' -Token '1234-5678-9012-1234'

    .EXAMPLE
    Get resources that match the name provided to the resource parameter.
    Get-PMPResource -Server 'pmpserver01' -Token '1234-5678-9012-1234' -Resource 'server01'
#>

function Get-PMPResource {
    [CmdletBinding(DefaultParameterSetName = "Default")]

    param (
        [Parameter(Mandatory = $True)]
        [String]$Server,

        [Parameter(Mandatory = $True)]
        [String]$Token,
        
        [String]$Resource
    )

    try {
        $endpoint = 'resources'
        $method = 'get'
        
        try {
            $response = Invoke-PMPRestMethod -Server $Server -Token $Token -Endpoint $endpoint -Method $method
        } catch {
            $_
        }

        $resources = $response.operation.details

        if ($resource) {
            try {
                [pscustomobject]$resource = $resources | Where-Object {$_."RESOURCE NAME" -eq $Resource}
            } catch {
                throw "Unable to find resource $resource in any of the returned resources."
            }
        }        

        if ($resource) {
            Write-Output $resource
        } else {
            Write-Output $resources
        }

    } catch {
        Write-Error "Error trying to $method passwords with token $token."
        throw $_
    }
}