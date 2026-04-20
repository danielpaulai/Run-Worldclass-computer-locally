# Launch a chat with the model chosen by setup.ps1.

$scriptDir = Split-Path -Parent $PSCommandPath
$modelFile = Join-Path $scriptDir ".selected-model"

if (-not (Test-Path $modelFile)) {
  Write-Host "No model selected yet. Run .\setup.ps1 first."
  exit 1
}

$model = (Get-Content $modelFile -Raw).Trim()

function Test-OllamaUp {
  try {
    Invoke-WebRequest -Uri "http://localhost:11434/api/version" -UseBasicParsing -TimeoutSec 2 | Out-Null
    return $true
  } catch { return $false }
}

if (-not (Test-OllamaUp)) {
  Write-Host "Ollama is not running. Starting it..."
  Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden
  Start-Sleep -Seconds 3
}

Write-Host "Launching $model.  Type  /bye  to exit."
Write-Host ""
ollama run $model
