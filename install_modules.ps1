<#
    .SYNOPSIS
    Installs required PowerShell modules for the build process.
#>
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$modulesToInstall = @(
    @{
        ModuleName    = 'Pester'
        ModuleVersion = '5.3.3'
    }
    @{
        ModuleName    = 'platyPS'
        ModuleVersion = '0.14.2'
    }
    @{
        ModuleName    = 'PSScriptAnalyzer'
        ModuleVersion = '1.21.0'
    }
)

$installModule = @{
    Scope              = 'CurrentUser'
    AllowClobber       = $true
    Force              = $true
    SkipPublisherCheck = $true
    Verbose            = $false
}

$installedModules = Get-Module -ListAvailable

foreach ($module in $modulesToInstall) {
    Write-Host ('  - {0} {1}' -f $module.ModuleName, $module.ModuleVersion)

    if ($installedModules.Where( { $_.Name -eq $module.ModuleName -and $_.Version -eq $module.ModuleVersion } )) {
        Write-Host '      Already installed. Skipping...'
        continue
    }

    Install-Module -Name $module.ModuleName -RequiredVersion $module.ModuleVersion @installModule
    Import-Module -Name $module.ModuleName -Force
}
