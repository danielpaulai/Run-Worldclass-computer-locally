#!/usr/bin/env bash
#
# Run a World-Class AI on Your Laptop — one-command installer.
# Works on macOS and Linux.  For Windows, use setup.ps1 in PowerShell.
#
set -e

say()  { printf "\n\033[1;36m==>\033[0m %s\n" "$1"; }
ok()   { printf "\033[1;32m[ok]\033[0m  %s\n" "$1"; }
warn() { printf "\033[1;33m[!]\033[0m   %s\n" "$1"; }
die()  { printf "\033[1;31m[x]\033[0m   %s\n" "$1"; exit 1; }

# -------- 1. Detect OS --------
case "$(uname -s)" in
  Darwin) OS="macos" ; ok "macOS detected" ;;
  Linux)  OS="linux" ; ok "Linux detected" ;;
  *)      die "Unsupported OS: $(uname -s). For Windows, run setup.ps1 in PowerShell." ;;
esac

# -------- 2. Install Ollama (OS-specific) --------
if [[ "$OS" == "macos" ]]; then
  if ! command -v brew >/dev/null 2>&1; then
    say "Installing Homebrew (one-time; may ask for your Mac password)..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if   [[ -x /opt/homebrew/bin/brew ]]; then eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew    ]]; then eval "$(/usr/local/bin/brew shellenv)"
    fi
  else
    ok "Homebrew already installed"
  fi

  if ! command -v ollama >/dev/null 2>&1; then
    say "Installing Ollama..."
    brew install ollama
  else
    ok "Ollama already installed"
  fi

  if ! curl -s http://localhost:11434/api/version >/dev/null 2>&1; then
    say "Starting Ollama in the background..."
    brew services start ollama >/dev/null
  fi

elif [[ "$OS" == "linux" ]]; then
  if ! command -v ollama >/dev/null 2>&1; then
    say "Installing Ollama (official installer; may ask for sudo password)..."
    curl -fsSL https://ollama.com/install.sh | sh
  else
    ok "Ollama already installed"
  fi

  if ! curl -s http://localhost:11434/api/version >/dev/null 2>&1; then
    say "Starting Ollama..."
    if command -v systemctl >/dev/null 2>&1; then
      sudo systemctl start ollama 2>/dev/null || nohup ollama serve >/tmp/ollama.log 2>&1 &
    else
      nohup ollama serve >/tmp/ollama.log 2>&1 &
    fi
  fi
fi

# -------- 3. Wait for Ollama to come online --------
for _ in $(seq 1 15); do
  if curl -s http://localhost:11434/api/version >/dev/null 2>&1; then break; fi
  sleep 1
done
curl -s http://localhost:11434/api/version >/dev/null 2>&1 \
  || die "Ollama did not start. Try restarting the service and re-running ./setup.sh"
ok "Ollama is running at http://localhost:11434"

# -------- 4. Detect RAM --------
if [[ "$OS" == "macos" ]]; then
  RAM_BYTES=$(sysctl -n hw.memsize)
else
  RAM_KB=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)
  RAM_BYTES=$(( RAM_KB * 1024 ))
fi
RAM_GB=$(( RAM_BYTES / 1024 / 1024 / 1024 ))

# -------- 5. Pick a model --------
if   (( RAM_GB >= 64 )); then MODEL="gpt-oss:20b"
elif (( RAM_GB >= 32 )); then MODEL="qwen2.5:14b"
elif (( RAM_GB >= 16 )); then MODEL="qwen2.5:7b"
elif (( RAM_GB >=  8 )); then MODEL="llama3.2:3b"
else
  die "Only ${RAM_GB} GB RAM detected. 8 GB is the minimum to run a local model comfortably."
fi
say "Detected ${RAM_GB} GB RAM -> choosing model: ${MODEL}"

# -------- 6. Pull the model (skip if already present) --------
if ollama list | awk 'NR>1 {print $1}' | grep -qx "$MODEL"; then
  ok "Model already downloaded: $MODEL"
else
  say "Downloading $MODEL. First time only — grab a coffee."
  ollama pull "$MODEL"
fi

# -------- 7. Remember the choice --------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo "$MODEL" > "$SCRIPT_DIR/.selected-model"

# -------- 8. Done --------
cat <<EOF

--------------------------------------------------
  Setup complete.

  Chat with your local AI:
      ./chat.sh

  Or directly:
      ollama run $MODEL

  To remove everything later:
      ./uninstall.sh
--------------------------------------------------
EOF
