<#
    .SYNOPSIS
     Gets a password from a PMP account.

    .DESCRIPTION
     Gets a password from a PMP account.

    .PARAMETER Server
     The server name.

    .PARAMETER Token
     The PMP API Token.

    .PARAMETER Resource
    The name of the resource.

    .PARAMETER Account
    The name of the account.

    .EXAMPLE
    Get PMP password for an account belonging to a resource.
    Get-PMPPassword -Server 'pmpserver' -Token '1234-5678-9012-1234' -Resource 'server01' -Account 'admin'
#>

function Get-PMPPassword {
    [CmdletBinding(DefaultParameterSetName = "Default")]

    param (
        [Parameter(Mandatory = $True)]
        [string]$Server,
        [Parameter(Mandatory = $True)]
        [string]$Token,
        [Parameter(Mandatory = $True)]
        [string]$Resource,
        [Parameter(Mandatory = $True)]
        [string]$Account
    )

    try {
        $resourceID = (Get-PMPResource -Server $Server -Token $Token -Resource $Resource).'RESOURCE ID'
        $accountID = (Get-PMPAccount -Server $Server -Token $Token -Resource $Resource -Account $Account).'ACCOUNT ID'
        $endpoint = "resources/$($resourceID)/accounts/$accountID/password"
        $method = 'GET'

        try {
            $response = Invoke-PMPRestMethod -Server $Server -Token $Token -Endpoint $endpoint -Method $method
        } catch {
            $_
        }

        Write-Output $response.operation.details
    } catch {
        throw $_
    }
}