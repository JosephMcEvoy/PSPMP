<#
    .SYNOPSIS
     Gets accounts from PMP.

    .DESCRIPTION
     Gets accounts from PMP.

    .PARAMETER Server
     The server name. This is required.

    .PARAMETER Token
     The PMP API Token. This is required.

    .PARAMETER Resource
    The name of the resource. This is required.

    .PARAMETER Account
    The name of the account. When this paramater is provided, the cmdlet will return all accounts under the
    resource that match the name provided.

    .EXAMPLE
    Get all PMP accounts for a resource.
    Get-PMPAccount -Server 'pmpserver' -Token '1234-5678-9012-1234' -Resource 'server01'

    .EXAMPLE
    Get a specific account for a resource.
    Get-PMPAccount -Server 'pmpserver' -Token '12345-12345-12345-12345-12345' -Resource 'server01' -Account 'jmcevoy'
#>

function Get-PMPAccount {
    [CmdletBinding(DefaultParameterSetName = "Default")]

    param (
        [Parameter(Mandatory = $True)]
        [string]$Server,

        [Parameter(Mandatory = $True)]
        [string]$Token,

        [Parameter(Mandatory = $True)]
        [string]$Resource,

        [string]$Account
    )

    try {
        $resourceID = (Get-PMPResource -Server $Server -Token $Token -Resource $Resource).'RESOURCE ID'

        $endpoint = "resources/$($resourceID)/accounts"
        $method = 'GET'

        try {
            $response = Invoke-PMPRestMethod -Server $Server -Token $Token -Endpoint $endpoint -Method $method
        } catch {
            $_
        }

        $accounts = $response.operation.details.'Account List'

        if ($account) {
            try {
                [pscustomobject]$account = $accounts | Where-Object {$_.'RESOURCE NAME' -eq $Account}
            } catch {
                throw "Unable to find resource $Account in any of the returned accounts from the resource $Resource."
            }
        }

        if ($account) {
            Write-Output $account
        } else {
            Write-Output $accounts
        }

    } catch {
        Write-Error "Error trying to $method passwords with token $token."
        throw $_
    }
}