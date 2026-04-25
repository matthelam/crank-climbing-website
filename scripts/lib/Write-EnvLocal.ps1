#requires -Version 5.1
<#
.SYNOPSIS
    Ensures .env.local exists, contains every required key, and prompts for missing values.
.DESCRIPTION
    Reads infrastructure/secrets/policy.yaml, copies .env.local.example into .env.local
    if missing, then for any required key with an empty value, prompts the human for input.
    Existing values are never overwritten.
#>

function Sync-EnvLocal {
    [CmdletBinding()]
    param()

    $repoRoot   = Join-Path $PSScriptRoot "..\.."
    $exampleSrc = Join-Path $repoRoot ".env.local.example"
    $envPath    = Join-Path $repoRoot ".env.local"

    Import-Module (Join-Path $PSScriptRoot "Read-Bindings.ps1") -Force
    $policy = Read-InfraYaml -RelativePath "infrastructure/secrets/policy.yaml"

    if (-not (Test-Path $envPath)) {
        Copy-Item -Path $exampleSrc -Destination $envPath
        Write-Host "Created .env.local from template." -ForegroundColor Green
    }

    # Parse existing .env.local into a map
    $current = @{}
    Get-Content $envPath | ForEach-Object {
        $line = $_.Trim()
        if ($line -and -not $line.StartsWith("#")) {
            $kv = $line -split "=", 2
            if ($kv.Count -eq 2) { $current[$kv[0].Trim()] = $kv[1].Trim() }
        }
    }

    $changed = $false
    foreach ($s in $policy.secrets) {
        $name = $s.name
        if (-not $current.ContainsKey($name) -or [string]::IsNullOrWhiteSpace($current[$name])) {
            Write-Host ""
            Write-Host "Missing required secret: $name" -ForegroundColor Yellow
            Write-Host "  Purpose: $($s.purpose)"
            if ($s.obtain_from_url) { Write-Host "  Obtain : $($s.obtain_from_url)" }
            $value = Read-Host "  Value (input hidden)" -AsSecureString
            $bstr  = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($value)
            $plain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($bstr)
            [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($bstr)
            if ([string]::IsNullOrWhiteSpace($plain)) {
                Write-Warning "  skipped (empty)"
                continue
            }
            $current[$name] = $plain
            $changed = $true
        }
    }

    if ($changed) {
        # Rewrite preserving template comments where possible
        $tmpl = Get-Content $exampleSrc
        $out  = New-Object System.Collections.Generic.List[string]
        foreach ($line in $tmpl) {
            if ($line -match "^([A-Z_][A-Z0-9_]*)=") {
                $key = $Matches[1]
                if ($current.ContainsKey($key)) {
                    $out.Add("$key=$($current[$key])")
                    $current.Remove($key) | Out-Null
                } else {
                    $out.Add($line)
                }
            } else {
                $out.Add($line)
            }
        }
        # Append any keys that weren't in the template
        foreach ($k in $current.Keys) {
            $out.Add("$k=$($current[$k])")
        }
        Set-Content -Path $envPath -Value $out -Encoding utf8
        Write-Host "Updated .env.local with $($current.Count) values." -ForegroundColor Green
    }

    return [PSCustomObject]@{
        Path = $envPath
        SecretsRequired = ($policy.secrets | Measure-Object).Count
        SecretsPresent  = (($current.Keys | Where-Object { -not [string]::IsNullOrWhiteSpace($current[$_]) }) | Measure-Object).Count
    }
}

Export-ModuleMember -Function Sync-EnvLocal
