# Run a World-Class AI on Your Laptop — Windows installer.
# Usage (in PowerShell):
#   .\setup.ps1

$ErrorActionPreference = "Stop"

function Say  ($m) { Write-Host "`n==> $m" -ForegroundColor Cyan }
function Ok   ($m) { Write-Host "[ok]  $m" -ForegroundColor Green }
function Warn ($m) { Write-Host "[!]   $m" -ForegroundColor Yellow }
function Die  ($m) { Write-Host "[x]   $m" -ForegroundColor Red; exit 1 }

# -------- 1. Pre-flight --------
if (-not $IsWindows -and $PSVersionTable.PSVersion.Major -ge 6) {
  Die "setup.ps1 is the Windows installer. On macOS or Linux, use ./setup.sh instead."
}
Ok "Windows detected"

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
  Die "winget is required. Install 'App Installer' from the Microsoft Store, then re-run this script."
}

# -------- 2. Install Ollama --------
if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
  Say "Installing Ollama via winget..."
  winget install --id Ollama.Ollama -e --silent --accept-source-agreements --accept-package-agreements
  # Refresh PATH for this session
  $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" +
              [System.Environment]::GetEnvironmentVariable("Path","User")
} else {
  Ok "Ollama already installed"
}

# -------- 3. Start Ollama --------
function Test-OllamaUp {
  try {
    Invoke-WebRequest -Uri "http://localhost:11434/api/version" -UseBasicParsing -TimeoutSec 2 | Out-Null
    return $true
  } catch { return $false }
}

if (-not (Test-OllamaUp)) {
  Say "Starting Ollama in the background..."
  Start-Process -FilePath "ollama" -ArgumentList "serve" -WindowStyle Hidden
  $tries = 0
  while (-not (Test-OllamaUp) -and $tries -lt 15) { Start-Sleep -Seconds 1; $tries++ }
}
if (-not (Test-OllamaUp)) { Die "Ollama did not start. Try restarting your machine and re-running this script." }
Ok "Ollama is running at http://localhost:11434"

# -------- 4. Detect RAM --------
$ramBytes = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory
$ramGB    = [math]::Floor($ramBytes / 1GB)

# -------- 5. Pick model --------
if     ($ramGB -ge 64) { $model = "gpt-oss:20b" }
elseif ($ramGB -ge 32) { $model = "qwen2.5:14b" }
elseif ($ramGB -ge 16) { $model = "qwen2.5:7b"  }
elseif ($ramGB -ge  8) { $model = "llama3.2:3b" }
else { Die "Only $ramGB GB RAM detected. 8 GB is the minimum to run a local model comfortably." }

Say "Detected $ramGB GB RAM -> choosing model: $model"

# -------- 6. Pull --------
$existing = (& ollama list | Select-Object -Skip 1) -match "^$([regex]::Escape($model))\s"
if ($existing) {
  Ok "Model already downloaded: $model"
} else {
  Say "Downloading $model. First time only — grab a coffee."
  ollama pull $model
}

# -------- 7. Remember choice --------
$scriptDir = Split-Path -Parent $PSCommandPath
Set-Content -Path (Join-Path $scriptDir ".selected-model") -Value $model -NoNewline

# -------- 8. Done --------
Write-Host ""
Write-Host "--------------------------------------------------"
Write-Host "  Setup complete."
Write-Host ""
Write-Host "  Chat with your local AI:"
Write-Host "      .\chat.ps1"
Write-Host ""
Write-Host "  Or directly:"
Write-Host "      ollama run $model"
Write-Host ""
Write-Host "  To remove everything later:"
Write-Host "      .\uninstall.ps1"
Write-Host "--------------------------------------------------"
