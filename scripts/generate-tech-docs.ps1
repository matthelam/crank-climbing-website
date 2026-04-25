#requires -Version 5.1
<#
.SYNOPSIS
    Regenerates docs/technology/<tool>.md stubs from bindings.yaml.
.DESCRIPTION
    Each capability with an ai_binding produces a stub at:
        docs/technology/<tool>.md

    The stub carries:
      - Tool name + version pin
      - Docs URL
      - Which capability it backs
      - Which layers consume it
      - A hand-authored body region (preserved across regenerations between
        <!-- generated:start --> ... <!-- generated:end --> markers)
#>
[CmdletBinding()]
param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$here = $PSScriptRoot
Import-Module (Join-Path $here "lib\Read-Bindings.ps1") -Force

$bindings  = Read-Bindings
$repoRoot  = Split-Path $here -Parent
$techDir   = Join-Path $repoRoot "docs\technology"
$layersDir = Join-Path $repoRoot "layers"

if (-not (Test-Path $techDir)) { New-Item -ItemType Directory -Path $techDir -Force | Out-Null }

# Build reverse index: capability_id -> [layer_id, ...]
$layerConsumers = @{}
Get-ChildItem $layersDir -Directory | ForEach-Object {
    $md = Join-Path $_.FullName "layer.md"
    if (-not (Test-Path $md)) { return }
    $body = Get-Content -Raw $md
    if ($body -match '## Bindings used\s*\r?\n\s*\r?\n((?:- [^\r\n]+\r?\n?)+)') {
        $list = $Matches[1] -split "\r?\n" | ForEach-Object {
            if ($_ -match '^-\s*`?([a-z][a-z0-9_]*)`?') { $Matches[1] }
        } | Where-Object { $_ }
        foreach ($capId in $list) {
            if (-not $layerConsumers.ContainsKey($capId)) { $layerConsumers[$capId] = @() }
            $layerConsumers[$capId] += $_.Name
        }
    }
}

foreach ($cid in $bindings.capabilities.Keys) {
    $cap = $bindings.capabilities[$cid]
    $b = $cap.ai_binding
    $tool = $b.tool
    $slug = ($tool -replace '[^\w\-\.]', '-') -replace '-+', '-'
    $path = Join-Path $techDir "$slug.md"

    $consumersStr = if ($layerConsumers.ContainsKey($cid)) {
        ($layerConsumers[$cid] | Sort-Object | ForEach-Object { "[``$_``](../../layers/$_/layer.md)" }) -join ", "
    } else {
        "—"
    }

    $generatedHeader = @"
# $tool

> **Generated stub.** Do not edit content between the `<!-- generated -->` markers.
> Hand-author your prose below the body marker; the generator preserves it.

| Field | Value |
|---|---|
| Capability | ``$cid`` |
| AI version pin | ``$($b.version)`` |
| Human binding | $(if ($cap.human_binding) { "``$($cap.human_binding.tool)`` ``$($cap.human_binding.version)``" } else { "—" }) |
| Last checked | $($cap.last_checked) |
| Upstream docs | $(if ($b.docs_url) { "<$($b.docs_url)>" } else { "—" }) |
| Layer consumers | $consumersStr |
"@

    $body = $null
    if (Test-Path $path) {
        $existing = Get-Content -Raw $path
        if ($existing -match '<!-- body:start -->\s*([\s\S]*?)\s*<!-- body:end -->') {
            $body = $Matches[1]
        }
    }
    if (-not $body) {
        $body = "_Hand-author per-tool notes here. Generator will preserve everything between the body markers._"
    }

    $rendered = @"
<!-- generated:start -->

$generatedHeader

<!-- generated:end -->

<!-- body:start -->

$body

<!-- body:end -->
"@

    if ($DryRun) {
        Write-Host "[dry] $path" -ForegroundColor DarkYellow
    } else {
        Set-Content -Path $path -Value $rendered -Encoding utf8
    }
}

Write-Host "regenerated tech docs in $techDir" -ForegroundColor Green
