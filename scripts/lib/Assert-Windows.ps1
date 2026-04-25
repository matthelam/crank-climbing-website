#requires -Version 5.1
<#
.SYNOPSIS
    Halts the bootstrap unless we're on Windows.
.DESCRIPTION
    Per the scaffold's binding constraints, OS support is Windows-only.
    Other OSes are out of scope and the user is asked to confirm before proceeding
    on anything else.
#>

function Assert-Windows {
    [CmdletBinding()]
    param(
        [string]$MinVersion = "10.0.22621"
    )

    $isWin = $false
    if ($PSVersionTable.PSVersion.Major -ge 6) {
        $isWin = $IsWindows
    } else {
        # Windows PowerShell 5.1 is Windows-only
        $isWin = $true
    }

    if (-not $isWin) {
        Write-Error @"
This scaffold targets Windows only. Detected non-Windows host.
The bootstrap will halt. If you want cross-platform support, that is a
scaffold change that needs explicit human approval — see CLAUDE.md.
"@
        throw "non-windows host"
    }

    $current = [System.Environment]::OSVersion.Version
    $minimum = [Version]$MinVersion
    if ($current -lt $minimum) {
        Write-Warning "Detected Windows $current, declared minimum is $minimum. Continuing but verify compatibility."
    }

    return $true
}

Export-ModuleMember -Function Assert-Windows
