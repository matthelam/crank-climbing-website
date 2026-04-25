#requires -Version 5.1
<#
.SYNOPSIS
    Loads bindings.yaml as a PowerShell object.
.DESCRIPTION
    bindings.yaml is the single source of truth for tool selections and install methods.
    This module returns it as a hashtable so other scripts can iterate capabilities.
#>

function Read-Bindings {
    [CmdletBinding()]
    param(
        [string]$Path = (Join-Path $PSScriptRoot "..\..\bindings.yaml")
    )

    if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
        Write-Host "Installing powershell-yaml module (one-time, current user scope)..."
        Install-Module -Name powershell-yaml -Scope CurrentUser -Force -SkipPublisherCheck
    }
    Import-Module powershell-yaml -Force

    $resolved = Resolve-Path $Path
    $raw = Get-Content -Raw -Path $resolved
    $data = ConvertFrom-Yaml -Yaml $raw
    return $data
}

function Read-InfraYaml {
    [CmdletBinding()]
    param([Parameter(Mandatory)][string]$RelativePath)

    if (-not (Get-Module -ListAvailable -Name powershell-yaml)) {
        Install-Module -Name powershell-yaml -Scope CurrentUser -Force -SkipPublisherCheck
    }
    Import-Module powershell-yaml -Force

    $root = Join-Path $PSScriptRoot "..\.."
    $full = Join-Path $root $RelativePath
    $raw  = Get-Content -Raw -Path $full
    return ConvertFrom-Yaml -Yaml $raw
}

Export-ModuleMember -Function Read-Bindings, Read-InfraYaml
