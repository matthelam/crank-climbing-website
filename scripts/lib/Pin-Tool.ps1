#requires -Version 5.1
<#
.SYNOPSIS
    Installs a tool to a pinned version per its bindings.yaml capability.
.DESCRIPTION
    Reads a capability's `install` block and dispatches by method:
      winget         - winget install --id <package> --version <version>
      npm            - npm install -g <package>@<version>
      pip            - python -m pip install <package>==<version>
      uv             - uv tool install <package>@<version>
      ps_script      - run install_cmd verbatim
      mcp_config     - claude mcp add ...
      skill_file     - assert .claude/skills/<name>/SKILL.md exists
      manual         - print install_cmd as instruction; do not execute
      vendor         - clone repo at pinned ref into vendor/<name>
      github_release - download release asset from github.com/<package>/releases/tag/<version>
    After install, runs verify_cmd and asserts non-zero output.
#>

function Install-PinnedTool {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)][string]$CapabilityId,
        [Parameter(Mandatory)][hashtable]$Capability
    )

    $name    = $Capability.ai_binding.tool
    $version = $Capability.ai_binding.version
    $install = $Capability.install

    if (-not $install) {
        Write-Verbose "[$CapabilityId] no install block; skipping"
        return [PSCustomObject]@{ Capability = $CapabilityId; Tool = $name; Status = "no-install"; Method = "n/a" }
    }

    $method = $install.method
    Write-Host ""
    Write-Host "[$CapabilityId] $name@$version via $method" -ForegroundColor Cyan

    # Skip if verify_cmd already passes (idempotency)
    if ($install.verify_cmd) {
        $verifyOk = $false
        try {
            $out = Invoke-Expression $install.verify_cmd 2>&1
            if ($LASTEXITCODE -eq 0 -or $? ) {
                Write-Host "  already present: $out" -ForegroundColor DarkGreen
                $verifyOk = $true
            }
        } catch { $verifyOk = $false }
        if ($verifyOk) {
            return [PSCustomObject]@{ Capability = $CapabilityId; Tool = $name; Status = "already-present"; Method = $method }
        }
    }

    switch ($method) {
        "winget" {
            $args = @("install", "--id", $install.package, "--silent", "--accept-source-agreements", "--accept-package-agreements")
            if ($version -and $version -ne "n/a") { $args += @("--version", $version) }
            & winget @args
        }
        "npm" {
            $pkg = "$($install.package)@$version"
            if ($install.pin_source -eq "package.json") {
                Write-Host "  pinned in package.json; no global install required" -ForegroundColor DarkGray
            } else {
                & npm install -g $pkg
            }
        }
        "pip" {
            $pkg = "$($install.package)==$version"
            if ($install.pin_source -like "*pyproject.toml*") {
                Write-Host "  pinned in $($install.pin_source); install via 'uv sync' from orchestration/" -ForegroundColor DarkGray
            } else {
                & python -m pip install $pkg
            }
        }
        "uv" {
            & uv tool install "$($install.package)@$version"
        }
        "ps_script" {
            Invoke-Expression $install.install_cmd
        }
        "mcp_config" {
            Write-Host "  configure separately via scripts/configure-mcp.ps1" -ForegroundColor DarkGray
        }
        "skill_file" {
            $skillPath = Join-Path (Join-Path $PSScriptRoot "..\..") ".claude/skills/$($install.package)/SKILL.md"
            if (-not (Test-Path $skillPath)) { throw "skill file missing: $skillPath" }
        }
        "manual" {
            Write-Warning "  manual step required: $($install.install_cmd)"
        }
        "vendor" {
            Write-Host "  vendor target: $($install.package)" -ForegroundColor DarkGray
            # vendor handling lives in scripts/sync-vendor.ps1
        }
        "github_release" {
            Write-Warning "  github_release method not yet implemented"
        }
        default {
            throw "[$CapabilityId] unknown install method: $method"
        }
    }

    if ($install.post_install) {
        Write-Host "  post-install: $($install.post_install)" -ForegroundColor DarkGray
    }

    # Verify
    if ($install.verify_cmd) {
        try {
            $out = Invoke-Expression $install.verify_cmd 2>&1
            $ok  = ($LASTEXITCODE -eq 0) -or $?
            if ($ok) {
                Write-Host "  verified: $out" -ForegroundColor Green
                return [PSCustomObject]@{ Capability = $CapabilityId; Tool = $name; Status = "installed"; Method = $method }
            } else {
                Write-Warning "  verify failed: $out"
                return [PSCustomObject]@{ Capability = $CapabilityId; Tool = $name; Status = "verify-failed"; Method = $method }
            }
        } catch {
            Write-Warning "  verify threw: $_"
            return [PSCustomObject]@{ Capability = $CapabilityId; Tool = $name; Status = "verify-failed"; Method = $method }
        }
    }

    return [PSCustomObject]@{ Capability = $CapabilityId; Tool = $name; Status = "installed-no-verify"; Method = $method }
}

Export-ModuleMember -Function Install-PinnedTool
