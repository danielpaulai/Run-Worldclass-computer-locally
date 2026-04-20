#!/usr/bin/env bash
# Restart Ollama via whatever is appropriate on this OS.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
say "Restarting Ollama..."
case "$(uname -s)" in
  Darwin)
    brew services restart ollama
    ;;
  Linux)
    if command -v systemctl >/dev/null 2>&1; then
      sudo systemctl restart ollama
    else
      pkill -f "ollama serve" 2>/dev/null || true
      nohup ollama serve >/tmp/ollama.log 2>&1 &
    fi
    ;;
esac
for _ in $(seq 1 15); do
  ollama_up && { ok "Ollama is back up."; exit 0; }
  sleep 1
done
die "Ollama did not come back up.  Check logs: ./ai model-doctor logs"
