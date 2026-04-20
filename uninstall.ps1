# Fully remove Ollama, downloaded models, and this tool's state (Windows).

$confirm = Read-Host "This will uninstall Ollama and delete all downloaded models. Continue? [y/N]"
if ($confirm -notin @("y","Y","yes","YES")) {
  Write-Host "Cancelled."
  exit 0
}

# Stop any running Ollama processes
Get-Process -Name "ollama*" -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue

# Uninstall via winget (silent if not present)
winget uninstall --id Ollama.Ollama -e --silent 2>$null

# Remove model data directory
$ollamaData = Join-Path $env:USERPROFILE ".ollama"
if (Test-Path $ollamaData) { Remove-Item -Recurse -Force $ollamaData }

# Remove this tool's state file
$scriptDir = Split-Path -Parent $PSCommandPath
$modelFile = Join-Path $scriptDir ".selected-model"
if (Test-Path $modelFile) { Remove-Item -Force $modelFile }

Write-Host "Done. Ollama and its models have been removed."
