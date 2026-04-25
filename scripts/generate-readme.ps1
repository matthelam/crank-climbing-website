#requires -Version 5.1
<#
.SYNOPSIS
    Regenerates the Standard Platform and Workflow tables in README.md from
    bindings.yaml + layers/.
.DESCRIPTION
    Edits ONLY content between the matching marker pairs. Hand-authored prose
    elsewhere is preserved exactly.

    Markers used:
        <!-- generated:standard-platform:start -->
        <!-- generated:standard-platform:end -->
        <!-- generated:workflow:start -->
        <!-- generated:workflow:end -->
        <!-- generated:layer-index:start -->
        <!-- generated:layer-index:end -->

    If a marker pair is missing, the section is appended at the end of README.md
    with a heading.
.EXAMPLE
    pwsh ./scripts/generate-readme.ps1
#>
[CmdletBinding()]
param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"
$here = $PSScriptRoot
Import-Module (Join-Path $here "lib\Read-Bindings.ps1") -Force

$bindings = Read-Bindings
$repoRoot = Split-Path $here -Parent
$readme = Join-Path $repoRoot "README.md"

# ── Build Standard Platform table ────────────────────────────────────────────
$catLabels = [ordered]@{
    core       = "Core"
    frontend   = "Frontend"
    design     = "Design"
    quality    = "Quality"
    ai_tooling = "AI tooling"
    extraction = "Extraction"
    operations = "Operations"
    infra      = "Infra"
}

$rows = @()
foreach ($cat in $catLabels.Keys) {
    foreach ($cid in ($bindings.capabilities.Keys | Sort-Object)) {
        $cap = $bindings.capabilities[$cid]
        if ($cap.category -ne $cat) { continue }
        $b = $cap.ai_binding
        $hb = $cap.human_binding
        $human = if ($hb) { "$($hb.tool) $($hb.version)" } else { "—" }
        $rows += [PSCustomObject]@{
            Category    = $catLabels[$cat]
            Capability  = $cid
            Description = $cap.description
            AI          = "**$($b.tool)** ``$($b.version)``"
            Human       = $human
            Docs        = $b.docs_url
        }
    }
}

$spLines = @(
    "| Category | Capability | Signal | AI binding | Human binding | Docs |",
    "|---|---|---|---|---|---|"
)
foreach ($r in $rows) {
    $docs = if ($r.Docs) { "[link]($($r.Docs))" } else { "—" }
    $spLines += "| $($r.Category) | ``$($r.Capability)`` | $($r.Description) | $($r.AI) | $($r.Human) | $docs |"
}
$spBlock = ($spLines -join "`n")

# ── Build Workflow / layer-index table ───────────────────────────────────────
Import-Module (Join-Path $here "lib\Read-Bindings.ps1") -Force
$layersRoot = Join-Path $repoRoot "layers"
$layerIds = @(
    "00-bootstrap","01-business-decomposition","02-brand-kit","03-ux",
    "04-scope","05-elaboration","06-requirements","07-stories-tasks",
    "08-red-tests","09-recursive-build","10-local-verification","11-pull-request",
    "12-dual-ac-verification","13-review","14-merge-deploy-observe","M-maintenance"
)

$wfLines = @("| # | Layer | Purpose | HITL | Skill |", "|---|---|---|---|---|")
foreach ($lid in $layerIds) {
    $layerMd = Join-Path $layersRoot "$lid\layer.md"
    $purpose = "—"
    if (Test-Path $layerMd) {
        $body = Get-Content -Raw $layerMd
        if ($body -match '\*\*Purpose\.\*\*\s*([^\r\n]+)') { $purpose = $Matches[1].Trim() }
    }
    $gates = Join-Path $layersRoot "$lid\gates.yaml"
    $hitl = "?"
    if (Test-Path $gates) {
        $g = Get-Content $gates -Raw
        if ($g -match 'policy:\s*(\w+)') { $hitl = $Matches[1] }
    }
    $skillLink = "[``/layer-$lid``](.claude/skills/layer-$lid/SKILL.md)"
    $num = if ($lid -eq "M-maintenance") { "M" } else { $lid.Substring(0,2) }
    $wfLines += "| $num | [``$lid``](layers/$lid/layer.md) | $purpose | $hitl | $skillLink |"
}
$wfBlock = ($wfLines -join "`n")

# ── Splice into README ───────────────────────────────────────────────────────
function Splice-Markers {
    param([string]$Text, [string]$Section, [string]$Block)
    $start = "<!-- generated:$Section`:start -->"
    $end   = "<!-- generated:$Section`:end -->"
    $pattern = [regex]::Escape($start) + '.*?' + [regex]::Escape($end)
    $replacement = "$start`n`n$Block`n`n$end"
    if ($Text -match $pattern) {
        return [regex]::Replace($Text, $pattern, $replacement, [System.Text.RegularExpressions.RegexOptions]::Singleline)
    } else {
        return $Text + "`n`n## Generated: $Section`n`n" + $replacement + "`n"
    }
}

$current = Get-Content -Raw $readme
$current = Splice-Markers -Text $current -Section "standard-platform" -Block $spBlock
$current = Splice-Markers -Text $current -Section "workflow"           -Block $wfBlock
$current = Splice-Markers -Text $current -Section "layer-index"        -Block $wfBlock

if ($DryRun) {
    Write-Host "[dry] would update $readme" -ForegroundColor DarkYellow
} else {
    Set-Content -Path $readme -Value $current -Encoding utf8
    Write-Host "regenerated: $readme" -ForegroundColor Green
}
