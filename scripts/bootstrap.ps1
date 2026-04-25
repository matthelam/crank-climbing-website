#requires -Version 5.1
<#
.SYNOPSIS
    Crank Scaffold cold-start bootstrap.
.DESCRIPTION
    Idempotent. Run on a fresh clone (or any time bindings.yaml changes) to converge
    the local environment, MCPs, secrets, and external state to declared state.

    Reads:
      bindings.yaml
      infrastructure/vm/tooling.yaml
      infrastructure/mcp/servers.yaml
      infrastructure/agent/skills.yaml
      infrastructure/secrets/policy.yaml
      infrastructure/github/repo.yaml      (optional in this run)
      infrastructure/vercel/project.yaml   (optional in this run)

    Writes:
      .env.local                                        (created/updated as needed)
      intent/bootstrap/{timestamp}.md                   (run report)

    Exits non-zero on any required-tool verify failure.
.PARAMETER SkipInstall
    Skip the install pass; only verify what's present.
.PARAMETER SkipSecrets
    Skip the .env.local interactive prompt.
.EXAMPLE
    pwsh ./scripts/bootstrap.ps1
.EXAMPLE
    pwsh ./scripts/bootstrap.ps1 -SkipSecrets
#>
[CmdletBinding()]
param(
    [switch]$SkipInstall,
    [switch]$SkipSecrets
)

$ErrorActionPreference = "Stop"
$here = $PSScriptRoot

Import-Module (Join-Path $here "lib\Assert-Windows.ps1")  -Force
Import-Module (Join-Path $here "lib\Read-Bindings.ps1")   -Force
Import-Module (Join-Path $here "lib\Pin-Tool.ps1")        -Force
Import-Module (Join-Path $here "lib\Write-EnvLocal.ps1")  -Force

Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host " Crank Scaffold Bootstrap (layer 00)" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

Assert-Windows | Out-Null

Write-Host ""
Write-Host "Loading bindings.yaml..." -ForegroundColor Cyan
$bindings = Read-Bindings
Write-Host "  $($bindings.capabilities.Keys.Count) capabilities declared"

Write-Host ""
Write-Host "Loading infrastructure/vm/tooling.yaml..." -ForegroundColor Cyan
$tooling = Read-InfraYaml -RelativePath "infrastructure/vm/tooling.yaml"

# Install pass
$results = New-Object System.Collections.Generic.List[object]
if (-not $SkipInstall) {
    Write-Host ""
    Write-Host "Install pass..." -ForegroundColor Cyan
    foreach ($tool in $tooling.tools) {
        $cap = $bindings.capabilities[$tool.binding_capability]
        if (-not $cap) {
            Write-Warning "tooling.yaml references unknown capability '$($tool.binding_capability)'; skipping"
            continue
        }
        $r = Install-PinnedTool -CapabilityId $tool.binding_capability -Capability $cap
        $results.Add($r)
    }
} else {
    Write-Host "Install pass skipped." -ForegroundColor DarkYellow
}

# Secrets pass
if (-not $SkipSecrets) {
    Write-Host ""
    Write-Host "Secrets pass..." -ForegroundColor Cyan
    $envInfo = Sync-EnvLocal
    Write-Host "  .env.local has $($envInfo.SecretsPresent) of $($envInfo.SecretsRequired) declared secrets present."
} else {
    Write-Host "Secrets pass skipped." -ForegroundColor DarkYellow
}

# MCP server pass — delegated to Claude Code's `claude mcp add` invocations.
# Implementation deferred: scripts/configure-mcp.ps1 (Phase 4 generator).
Write-Host ""
Write-Host "MCP configuration pass — delegated to scripts/configure-mcp.ps1 (run separately)." -ForegroundColor DarkGray

# Skills pass — assert .claude/skills/<name>/SKILL.md exists for each declared skill.
Write-Host ""
Write-Host "Skills pass..." -ForegroundColor Cyan
$skillsDoc = Read-InfraYaml -RelativePath "infrastructure/agent/skills.yaml"
$skillResults = @()
foreach ($s in $skillsDoc.skills) {
    $p = Join-Path (Split-Path $here -Parent) ".claude\skills\$($s.name)\SKILL.md"
    if (Test-Path $p) {
        $skillResults += [PSCustomObject]@{ Skill = $s.name; Status = "present" }
    } else {
        $skillResults += [PSCustomObject]@{ Skill = $s.name; Status = "MISSING" }
    }
}
$missing = ($skillResults | Where-Object Status -eq "MISSING").Count
Write-Host "  $($skillResults.Count - $missing) of $($skillResults.Count) skill files present."
if ($missing -gt 0) {
    Write-Warning "  $missing skill files missing. Run scripts/generate-skills.ps1 to scaffold them."
}

# Write report
$tsDir   = Join-Path (Split-Path $here -Parent) "intent\bootstrap"
if (-not (Test-Path $tsDir)) { New-Item -ItemType Directory -Path $tsDir -Force | Out-Null }
$ts      = (Get-Date -Format "yyyy-MM-dd-HHmmss")
$report  = Join-Path $tsDir "$ts.md"

$lines = @(
    "# Bootstrap run — $ts",
    ""
    "**Layer:** 00-bootstrap",
    "**Host:** $env:COMPUTERNAME ($([System.Environment]::OSVersion.Version))",
    "**Operator:** $env:USERNAME",
    ""
    "## Tool install results",
    ""
    "| Capability | Tool | Method | Status |",
    "|---|---|---|---|"
)
foreach ($r in $results) {
    $lines += "| $($r.Capability) | $($r.Tool) | $($r.Method) | $($r.Status) |"
}
$lines += ""
$lines += "## Skills"
$lines += ""
$lines += "| Skill | Status |"
$lines += "|---|---|"
foreach ($r in $skillResults) { $lines += "| $($r.Skill) | $($r.Status) |" }

Set-Content -Path $report -Value $lines -Encoding utf8
Write-Host ""
Write-Host "Report written: $report" -ForegroundColor Green

# Exit code
$failed = ($results | Where-Object Status -in "verify-failed","install-failed").Count
if ($failed -gt 0) {
    Write-Error "$failed tool(s) failed to install or verify. See report."
    exit 1
}
if ($missing -gt 0) {
    Write-Warning "$missing skill(s) missing — bootstrap complete with caveats."
}
exit 0
