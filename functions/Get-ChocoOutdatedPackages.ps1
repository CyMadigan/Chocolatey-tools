
function Get-ChocoOutdatedPackages {
<#
.SYNOPSIS
    Find outdated packages from a local machine
.DESCRIPTION
    Wrapper around choco outdated -r. Ignores pinned and unfound packages from sources
.EXAMPLE
PS C:\> Get-ChocoOutdatedPackages

Name                 CurrentVersion Version       Pinned
----                 -------------- -------       ------
chocolatey.extension 2.0.1          2.0.2         false
curl                 7.64.0         7.64.1        false
GoogleChrome         73.0.3683.103  74.0.3729.131 false

#>
    [CmdletBinding()]
    param(
    )
        Write-Verbose "Getting local outdated packages"
        $OutdatedPackages = (choco outdated -r --ignore-pinned --ignore-unfound --timeout=60)
        if (!($OutdatedPackages)){
            Write-Verbose -Message 'No outdated packages'
            Exit
        }
        else {
            foreach ($NewPackage in $OutdatedPackages){
                [PSCustomObject]@{
                    Name = $NewPackage.Split('|')[0]
                    CurrentVersion = $NewPackage.Split('|')[1]
                    Version = $NewPackage.Split('|')[2]
                    Pinned = $NewPackage.Split('|')[3]
                }
            }
    }
}
