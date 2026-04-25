#requires -Version 5.1
<#
.SYNOPSIS
    Clone test for the scaffold — validates that the binding-swap workflow
    works end-to-end without modifying layers/ or orchestration/.
.DESCRIPTION
    This proves the cloneability principle (P8): layers and orchestration are
    framework-owned and stable; tool bindings swap freely via bindings.yaml.

    Steps:
      1. Clone this repo to a sibling directory `..\crank-clone-test`.
      2. Run bootstrap there.
      3. Edit ONLY bindings.yaml in the clone — swap one capability's tool
         (e.g., the `styling` capability from tailwindcss to vanilla-extract).
      4. Run a layer that depends on the swapped binding.
      5. Confirm: only bindings.yaml changed; layers/ and orchestration/ are
         byte-identical to source.

    This script prepares the clone but does NOT execute the rebuild — that
    requires interactive secrets prompting and is expected to be done by a
    human operator on first verification.
.EXAMPLE
    pwsh ./scripts/clone-test.ps1
#>
[CmdletBinding()]
param(
    [string]$ClonePath = (Join-Path (Split-Path (Split-Path $PSScriptRoot -Parent) -Parent) "crank-clone-test"),
    [switch]$SkipClone
)

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "Clone test preparation" -ForegroundColor Cyan
Write-Host "  source:      $(Split-Path $PSScriptRoot -Parent)"
Write-Host "  destination: $ClonePath"

if (-not $SkipClone) {
    if (Test-Path $ClonePath) {
        Write-Warning "destination exists; remove it and re-run, or pass -SkipClone."
        exit 1
    }
    git clone (Split-Path $PSScriptRoot -Parent) $ClonePath
}

Write-Host ""
Write-Host "Manual verification steps (run these in the clone):" -ForegroundColor Yellow
Write-Host @"

  cd $ClonePath
  pwsh ./scripts/bootstrap.ps1

  # Edit bindings.yaml — change a single capability's tool. Example:
  #   capabilities.styling.ai_binding.tool: tailwindcss -> vanilla-extract
  #   capabilities.styling.ai_binding.version: 4.0.0 -> 1.13.0
  #   capabilities.styling.install.package: tailwindcss -> @vanilla-extract/css
  notepad bindings.yaml

  # Re-run bootstrap (should converge to the new install).
  pwsh ./scripts/bootstrap.ps1

  # Confirm only bindings.yaml was edited.
  diff -r (Join-Path "$ClonePath" layers)         (Join-Path "$(Split-Path $PSScriptRoot -Parent)" layers)
  diff -r (Join-Path "$ClonePath" orchestration)  (Join-Path "$(Split-Path $PSScriptRoot -Parent)" orchestration)
  diff      (Join-Path "$ClonePath" bindings.yaml)(Join-Path "$(Split-Path $PSScriptRoot -Parent)" bindings.yaml)
"@

Write-Host ""
Write-Host "When the diffs above show:"
Write-Host "  - layers/        unchanged"           -ForegroundColor Green
Write-Host "  - orchestration/ unchanged"           -ForegroundColor Green
Write-Host "  - bindings.yaml  changed (the swap)"  -ForegroundColor Green
Write-Host ""
Write-Host "...then P8 (cloneable scaffold; swap bindings, not layers/workflow) is proven." -ForegroundColor Cyan
