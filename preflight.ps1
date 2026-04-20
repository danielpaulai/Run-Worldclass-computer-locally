# Preflight check — run BEFORE the session to confirm your laptop is ready (Windows).

$ok = 0; $warn = 0; $fail = 0

function Check($label, $status, $detail) {
  $tag = switch ($status) { "ok" {"[OK]"} "warn" {"[!!]"} "fail" {"[NO]"} }
  $color = switch ($status) { "ok" {"Green"} "warn" {"Yellow"} "fail" {"Red"} }
  Write-Host ("  {0,-5} {1,-28} {2}" -f $tag, $label, $detail) -ForegroundColor $color
  switch ($status) {
    "ok"   { $script:ok++ }
    "warn" { $script:warn++ }
    "fail" { $script:fail++ }
  }
}

Write-Host ""
Write-Host "------------------------------------------------------------"
Write-Host "  Preflight check — Run a World-Class AI on Your Laptop"
Write-Host "------------------------------------------------------------"

# --- OS ---
$os = (Get-CimInstance Win32_OperatingSystem).Caption
Check "Operating system" "ok" $os

# --- CPU arch ---
Check "CPU architecture" "ok" $env:PROCESSOR_ARCHITECTURE

# --- RAM ---
$ramGB = [math]::Floor((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
if     ($ramGB -ge 64) { $model = "gpt-oss:20b";  $size = "~13 GB"; Check "RAM" "ok"   "$ramGB GB" }
elseif ($ramGB -ge 32) { $model = "qwen2.5:14b";  $size = "~9 GB";  Check "RAM" "ok"   "$ramGB GB" }
elseif ($ramGB -ge 16) { $model = "qwen2.5:7b";   $size = "~5 GB";  Check "RAM" "ok"   "$ramGB GB" }
elseif ($ramGB -ge 8)  { $model = "llama3.2:3b";  $size = "~2 GB";  Check "RAM" "warn" "$ramGB GB (will work, but slower)" }
else                   { $model = "NONE";         $size = "N/A";    Check "RAM" "fail" "$ramGB GB (8 GB minimum)" }

# --- Free disk ---
$freeGB = [math]::Floor((Get-PSDrive -Name C).Free / 1GB)
if     ($freeGB -ge 30) { Check "Free disk space" "ok"   "$freeGB GB" }
elseif ($freeGB -ge 15) { Check "Free disk space" "warn" "$freeGB GB (tight)" }
else                    { Check "Free disk space" "fail" "$freeGB GB (need 15+ GB)" }

# --- Internet ---
function Test-Url($url) {
  try { Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5 | Out-Null; return $true }
  catch { return $false }
}
if (Test-Url "https://ollama.com") { Check "Internet to ollama.com" "ok" "reachable" } else { Check "Internet to ollama.com" "fail" "unreachable" }
if (Test-Url "https://github.com") { Check "Internet to github.com" "ok" "reachable" } else { Check "Internet to github.com" "fail" "unreachable" }

# --- Essentials ---
if (Get-Command git    -ErrorAction SilentlyContinue) { Check "git"    "ok" "installed" } else { Check "git"    "warn" "not found — install Git for Windows" }
if (Get-Command winget -ErrorAction SilentlyContinue) { Check "winget" "ok" "installed" } else { Check "winget" "fail" "install 'App Installer' from Microsoft Store" }

# --- Existing Ollama ---
if (Get-Command ollama -ErrorAction SilentlyContinue) {
  Check "Ollama" "ok" ((ollama --version 2>&1) -split "`n" | Select-Object -First 1)
} else {
  Check "Ollama" "ok" "not installed — setup.ps1 will install it"
}

# --- Summary ---
Write-Host "------------------------------------------------------------"
Write-Host ("  You will get:  {0}  ({1} download)" -f $model, $size) -ForegroundColor Green
Write-Host ""
Write-Host ("  {0} passed  /  {1} warnings  /  {2} blockers" -f $ok, $warn, $fail)
Write-Host "------------------------------------------------------------"

if ($fail -gt 0) {
  Write-Host ""
  Write-Host "  Fix the blockers above before running .\setup.ps1." -ForegroundColor Red
  exit 1
} else {
  Write-Host ""
  Write-Host "  You're good to go.  Run:  .\setup.ps1" -ForegroundColor Green
}
