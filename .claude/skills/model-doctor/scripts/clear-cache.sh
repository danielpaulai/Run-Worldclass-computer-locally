#!/usr/bin/env bash
# Unload all models from memory.  Next prompt will reload fresh.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama

# Ollama's /api/generate with keep_alive=0 unloads the model
say "Asking Ollama to unload all models..."
MODELS=$(ollama list | awk 'NR>1 {print $1}')
for m in $MODELS; do
  curl -s http://localhost:11434/api/generate \
    -d "{\"model\":\"$m\",\"keep_alive\":0}" >/dev/null || true
done
ok "Cache cleared.  Next prompt will load the model fresh."
