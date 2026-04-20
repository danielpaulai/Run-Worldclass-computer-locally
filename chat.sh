#!/usr/bin/env bash
#
# Launch a chat with the model chosen by setup.sh.  macOS and Linux.
#
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -f "$SCRIPT_DIR/.selected-model" ]]; then
  echo "No model selected yet. Run ./setup.sh first."
  exit 1
fi

MODEL=$(cat "$SCRIPT_DIR/.selected-model")

# Make sure Ollama is up
if ! curl -s http://localhost:11434/api/version >/dev/null 2>&1; then
  echo "Ollama is not running. Starting it..."
  case "$(uname -s)" in
    Darwin) brew services start ollama >/dev/null ;;
    Linux)
      if command -v systemctl >/dev/null 2>&1; then
        sudo systemctl start ollama 2>/dev/null || nohup ollama serve >/tmp/ollama.log 2>&1 &
      else
        nohup ollama serve >/tmp/ollama.log 2>&1 &
      fi ;;
  esac
  sleep 2
fi

echo "Launching $MODEL.  Type  /bye  to exit."
echo
ollama run "$MODEL"
