#!/usr/bin/env bash
#
# Preflight check — run BEFORE the session to confirm your laptop is ready.
# Tells you what model you'll get and flags anything that would block install.
#
set -e

green() { printf "\033[1;32m%s\033[0m" "$1"; }
yellow(){ printf "\033[1;33m%s\033[0m" "$1"; }
red()   { printf "\033[1;31m%s\033[0m" "$1"; }
line()  { printf -- "------------------------------------------------------------\n"; }

OK_COUNT=0
WARN_COUNT=0
FAIL_COUNT=0

check() {
  local label="$1" status="$2" detail="$3"
  case "$status" in
    ok)   printf "  [%s] %-28s %s\n" "$(green OK)"   "$label" "$detail"; OK_COUNT=$((OK_COUNT+1)) ;;
    warn) printf "  [%s] %-28s %s\n" "$(yellow !!)" "$label" "$detail"; WARN_COUNT=$((WARN_COUNT+1)) ;;
    fail) printf "  [%s] %-28s %s\n" "$(red NO)"   "$label" "$detail"; FAIL_COUNT=$((FAIL_COUNT+1)) ;;
  esac
}

line
echo "  Preflight check — Run a World-Class AI on Your Laptop"
line

# --- OS ---
case "$(uname -s)" in
  Darwin)
    OS="macOS $(sw_vers -productVersion)"
    check "Operating system" ok "$OS"
    ;;
  Linux)
    OS="$(. /etc/os-release 2>/dev/null && echo "$PRETTY_NAME" || echo "Linux")"
    check "Operating system" ok "$OS"
    ;;
  *)
    check "Operating system" fail "$(uname -s) — use setup.ps1 on Windows"
    ;;
esac

# --- CPU arch ---
ARCH=$(uname -m)
check "CPU architecture" ok "$ARCH"

# --- RAM ---
if [[ "$(uname -s)" == "Darwin" ]]; then
  RAM_GB=$(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 ))
elif [[ -r /proc/meminfo ]]; then
  RAM_GB=$(( $(awk '/^MemTotal:/ {print $2}' /proc/meminfo) / 1024 / 1024 ))
else
  RAM_GB=0
fi

if   (( RAM_GB >= 64 )); then MODEL="gpt-oss:20b"  ; SIZE="~13 GB" ; check "RAM" ok    "${RAM_GB} GB"
elif (( RAM_GB >= 32 )); then MODEL="qwen2.5:14b"  ; SIZE="~9 GB"  ; check "RAM" ok    "${RAM_GB} GB"
elif (( RAM_GB >= 16 )); then MODEL="qwen2.5:7b"   ; SIZE="~5 GB"  ; check "RAM" ok    "${RAM_GB} GB"
elif (( RAM_GB >=  8 )); then MODEL="llama3.2:3b"  ; SIZE="~2 GB"  ; check "RAM" warn  "${RAM_GB} GB (will work, but slower)"
else                          MODEL="NONE"         ; SIZE="N/A"    ; check "RAM" fail  "${RAM_GB} GB (8 GB minimum)"
fi

# --- Free disk space ---
FREE_GB=$(df -g "$HOME" 2>/dev/null | awk 'NR==2 {print $4}' || df -h "$HOME" | awk 'NR==2 {print $4}' | tr -d G)
if [[ -z "$FREE_GB" ]]; then FREE_GB=0; fi
if   (( FREE_GB >= 30 )); then check "Free disk space" ok   "${FREE_GB} GB"
elif (( FREE_GB >= 15 )); then check "Free disk space" warn "${FREE_GB} GB (tight)"
else                          check "Free disk space" fail "${FREE_GB} GB (need 15+ GB free)"
fi

# --- Internet ---
if curl -s --max-time 5 https://ollama.com >/dev/null 2>&1; then
  check "Internet to ollama.com" ok "reachable"
else
  check "Internet to ollama.com" fail "cannot reach ollama.com"
fi

if curl -s --max-time 5 https://github.com >/dev/null 2>&1; then
  check "Internet to github.com" ok "reachable"
else
  check "Internet to github.com" fail "cannot reach github.com"
fi

# --- Command-line essentials ---
command -v git  >/dev/null 2>&1 && check "git"  ok "installed" || check "git"  warn "not found (setup script will install)"
command -v curl >/dev/null 2>&1 && check "curl" ok "installed" || check "curl" fail "required but missing"

# --- Existing Ollama ---
if command -v ollama >/dev/null 2>&1; then
  check "Ollama" ok "$(ollama --version 2>&1 | head -1)"
else
  check "Ollama" ok "not installed — setup.sh will install it"
fi

# --- Summary ---
line
echo "  You will get:  $(green "$MODEL")  (${SIZE} download)"
echo
printf "  %s passed  /  %s warnings  /  %s blockers\n" \
  "$(green "$OK_COUNT")" "$(yellow "$WARN_COUNT")" "$(red "$FAIL_COUNT")"
line

if (( FAIL_COUNT > 0 )); then
  echo
  echo "  $(red "Fix the blockers above before running ./setup.sh.")"
  exit 1
else
  echo
  echo "  $(green "You're good to go.")  Run:  ./setup.sh"
fi
