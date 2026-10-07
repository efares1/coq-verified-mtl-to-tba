$ErrorActionPreference = 'Stop'
# MiKTeX may emit a nonfatal log4cxx access warning on native stderr in
# restricted workspaces. Treat native stderr as diagnostics; the explicit
# $LASTEXITCODE checks below still fail the build on a real tool error.
$PSNativeCommandUseErrorActionPreference = $false
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location -LiteralPath $projectRoot
New-Item -ItemType Directory -Force -Path (Join-Path $projectRoot 'build') | Out-Null
Get-ChildItem -LiteralPath $projectRoot -File |
    Where-Object { $_.Extension -in '.aux', '.bbl', '.blg', '.log', '.fls', '.fdb_latexmk' } |
    Remove-Item -Force
Get-ChildItem -LiteralPath (Join-Path $projectRoot 'build') -File |
    Where-Object { $_.Extension -in '.aux', '.bbl', '.blg', '.log', '.fls', '.fdb_latexmk' } |
    Remove-Item -Force

function Invoke-PdfLatex([string] $document) {
    $savedPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $nativeOutput = & pdflatex -disable-installer -interaction=nonstopmode -halt-on-error -output-directory=build $document 2>&1
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $savedPreference
    }
    if ($exitCode -ne 0) {
        $nativeOutput | ForEach-Object { Write-Output $_ }
        throw "pdflatex failed for $document with exit code $exitCode"
    }
}

function Invoke-Bibtex([string] $job) {
    $savedPreference = $ErrorActionPreference
    $ErrorActionPreference = 'Continue'
    try {
        $nativeOutput = & bibtex "build/$job" 2>&1
        $exitCode = $LASTEXITCODE
    } finally {
        $ErrorActionPreference = $savedPreference
    }
    if ($exitCode -ne 0) {
        $nativeOutput | ForEach-Object { Write-Output $_ }
        throw "bibtex failed for $job with exit code $exitCode"
    }
}

Invoke-PdfLatex 'paper1.tex'
Invoke-Bibtex 'paper1'
Invoke-PdfLatex 'supplement.tex'
Invoke-Bibtex 'supplement'
Invoke-PdfLatex 'paper1.tex'
Invoke-PdfLatex 'supplement.tex'
Invoke-PdfLatex 'paper1.tex'
Invoke-PdfLatex 'supplement.tex'
Invoke-PdfLatex 'paper1.tex'
Copy-Item -LiteralPath (Join-Path $projectRoot 'build/paper1.pdf') -Destination (Join-Path $projectRoot 'paper1.pdf') -Force
Copy-Item -LiteralPath (Join-Path $projectRoot 'build/supplement.pdf') -Destination (Join-Path $projectRoot 'supplement.pdf') -Force
Write-Output 'Built paper1.pdf and supplement.pdf (also available under build/).'
