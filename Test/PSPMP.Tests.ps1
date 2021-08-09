$module = 'PSPMP'
$root = (get-item (Split-Path -Parent $MyInvocation.MyCommand.Path)).parent
$modulePath = "$root\$module"
$publicPath = "$modulePath\Public"

Describe -Tags ('Unit', 'Acceptance') "$module Module Tests" {
    Context 'Module Setup' {
        It "has the root module $module.psm1" {
            "$modulePath\$module.psm1" | Should -Exist
        }
        
        It "has the manifestfile of $module.psd1" {
            "$modulePath\$module.psm1" | Should -Exist
            "$modulePath\$module.psd1" | Should -FileContentMatch "$module.psm1"
        }

        It "has these functions" {
            "$publicPath\Get-PMPAccount.ps1" | Should -Exist
            "$publicPath\Get-PMPPassword.ps1" | Should -Exist
            "$publicPath\Get-PMPResource.ps1" | Should -Exist
            "$publicPath\Invoke-PMPRestMethod.ps1" | Should -Exist
        }

        It "has the root module $module.psm1" {
            "$modulePath\$module.psm1" | Should -Exist
        }
    }
}