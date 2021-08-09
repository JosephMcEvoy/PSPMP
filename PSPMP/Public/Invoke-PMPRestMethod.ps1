<#
    .SYNOPSIS
     Invokes a rest method against a PMP server.
    
    .DESCRIPTION
     Invokes a rest method against a PMP server.
    
    .PARAMETER Server
     The server name and port where PMP is hosted.
    
    .PARAMETER Token
     The PMP API Token.

    .PARAMETER METHOD
    The method to use (get, post, put).

    .PARAMETER Endpoint
    The API endpoint. Example: 'resources'.
#>

function Invoke-PMPRestMethod {
    [CmdletBinding(DefaultParameterSetName = "Default")]

    param (
        [Parameter(Mandatory = $True)]
        [String]$Server,
        
        [Parameter(Mandatory = $True)]
        [String]$Token,

        [Parameter(Mandatory = $True)]
        [Microsoft.PowerShell.Commands.WebRequestMethod]$Method,

        [Parameter(Mandatory = $True)]
        [string]$endpoint
    )

    begin {
        Add-Type -AssemblyName System.Web
    }

    process {
        try {
            $request = [System.UriBuilder]"https://$($Server)/restapi/json/v1/$($endpoint)"
            $query = [System.Web.HttpUtility]::ParseQueryString([String]::Empty)
            $query.Add('AUTHTOKEN', $Token)
            $Request.Query = $query.ToString()
    
            try {
                $response = Invoke-RestMethod -Uri $request.Uri -Method $Method
            } catch {
                $_
            }
    
            Write-Output $response
        } catch {
            throw $_
        }
    }
}