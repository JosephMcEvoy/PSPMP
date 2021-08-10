# PSPMP
An API wrapper for ManageEngine's Password Manager Pro.

# Getting started #
## Using PowershellGallery ##
```
Install-Module PSPMP
Import-Module PSPMP
```

## Using Git ##
Clone the repository.
```
git clone "https://github.com/JosephMcEvoy/PSPMP.git"
```
Place directory into a module directory (e.g. $env:USERPROFILE\Documents\WindowsPowerShell\Modules).
```
Move-Item -path ".\pspmp\pspmp" -Destination "$env:USERPROFILE\Documents\WindowsPowerShell\Modules"
```
Import the module.
```
Import-Module PSPMP
```
After loading the module, use `Get-Help PSPMP` to learn more about available commands.

# Get your API token #
Find instructions for generating tokens at https://www.manageengine.com/products/passwordmanagerpro/help/add_api_user.html.
