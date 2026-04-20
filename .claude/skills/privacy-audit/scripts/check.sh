#!/usr/bin/env bash
# Full privacy audit.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
HERE="$(dirname "${BASH_SOURCE[0]}")"

say "1. Ollama binding"
"$HERE/listeners.sh" || true

echo
say "2. Where Ollama stores your model files"
DIR="$HOME/.ollama"
if [[ -d "$DIR" ]]; then
  ls -la "$DIR" | head -10
  echo
  ok "All model files are in:  $DIR  (on your local disk only)"
else
  warn "No ~/.ollama directory — Ollama may not be fully set up."
fi

echo
say "3. Environment variables that would route Ollama elsewhere"
env | grep -iE "^(OLLAMA|ANTHROPIC)_" || echo "  (none — good)"

echo
say "4. Sanity: can chat work with wifi off?"
echo "  (Run  ./chat.sh  with wifi disabled — it should work unchanged.)"
echo
ok "Audit complete.  Full report:  ./ai privacy-audit report"
