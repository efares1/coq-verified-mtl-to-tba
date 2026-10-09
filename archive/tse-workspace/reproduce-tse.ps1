param(
    [string] $RocqExe = 'C:\Rocq-Platform~9.0~2025.08\bin\rocq.exe',
    [string] $PythonExe = 'python'
)

$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $false
$root = Split-Path -Parent $MyInvocation.MyCommand.Path

if (-not (Test-Path -LiteralPath $RocqExe -PathType Leaf)) {
    throw "Rocq executable not found: $RocqExe. Pass -RocqExe <path-to-rocq.exe>."
}
$pythonCommand = Get-Command $PythonExe -ErrorAction SilentlyContinue
if (-not $pythonCommand) {
    throw "Python executable not found: $PythonExe. Pass -PythonExe <command-or-path>."
}

function Invoke-CheckedNative([string] $Executable, [string[]] $Arguments, [string] $Description) {
    & $Executable @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "$Description failed with exit code $LASTEXITCODE"
    }
}

$versionLines = & $RocqExe --version 2>&1
if ($LASTEXITCODE -ne 0) { throw 'Rocq version check failed' }
$versionText = $versionLines -join "`n"
if ($versionText -notmatch 'Rocq(?:\s+Prover,\s*version)?\s+9\.0\.1') {
    throw "Expected Rocq 9.0.1; found: $versionText"
}
Write-Output $versionText

$proofDir = Join-Path $root 'proof'
Push-Location -LiteralPath $proofDir
try {
    Invoke-CheckedNative $RocqExe @('compile', 'MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v') 'Core compilation'
    Invoke-CheckedNative $RocqExe @('compile', 'EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v') 'Correctness proof compilation'
    Invoke-CheckedNative $RocqExe @('compile', 'OverlappingResponse_Example.v') 'Alarm example compilation'
    $modules = @(
        'MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core'
        'EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof'
        'OverlappingResponse_Example'
    )
    Invoke-CheckedNative $RocqExe (@('check', '-silent') + $modules) 'Independent Rocq kernel check'

    $auditOutput = & $RocqExe compile CheckAssumptions.v 2>&1
    $auditExit = $LASTEXITCODE
    if ($auditExit -ne 0) { throw "Assumption audit failed with exit code $auditExit" }
    $actualAudit = (($auditOutput | ForEach-Object { [string]$_ }) -join "`n").TrimEnd() + "`n"
    $expectedAudit = [IO.File]::ReadAllText((Join-Path $proofDir 'ASSUMPTIONS.txt'))
    $normalize = { param($s) (($s -replace "`r`n?", "`n").TrimEnd() + "`n") }
    if ((& $normalize $actualAudit) -cne (& $normalize $expectedAudit)) {
        throw 'Regenerated assumptions differ from proof/ASSUMPTIONS.txt; the checked-in audit was left unchanged.'
    }
    Write-Output 'PASS: regenerated assumption report matches proof/ASSUMPTIONS.txt (file preserved).'
} finally {
    Pop-Location
}

$graphCheck = Join-Path $root 'examples/assurance/check_spot_transcription.py'
$scenarioCheck = Join-Path $root 'examples/assurance/reset_policy_scenarios.py'
Invoke-CheckedNative $pythonCommand.Source @($graphCheck, '--self-test') 'Spot transcription consistency check'
Invoke-CheckedNative $pythonCommand.Source @($scenarioCheck) 'Illustrative assurance scenarios'

$buildScript = Join-Path $root 'build.ps1'
& $buildScript
if ($LASTEXITCODE -ne 0) { throw "Paper build failed with exit code $LASTEXITCODE" }
Write-Output 'PASS: main manuscript and supplement compiled; PDFs were written to the root and build/ directory.'
