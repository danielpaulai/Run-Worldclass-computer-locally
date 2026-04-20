#!/usr/bin/env bash
# Show what's listening on ports, highlighting Ollama.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"

say "What's listening on your machine (TCP):"
echo
case "$(uname -s)" in
  Darwin|Linux)
    if command -v lsof >/dev/null 2>&1; then
      lsof -nP -iTCP -sTCP:LISTEN | awk 'NR==1 || /ollama/ || /:11434/' || true
      echo
      lsof -nP -iTCP -sTCP:LISTEN | awk 'NR>1 && !/ollama/ && !/11434/' | head -20
    else
      ss -ltnp 2>/dev/null || netstat -ltnp 2>/dev/null
    fi
    ;;
esac

echo
say "Ollama specifically:"
lsof -nP -iTCP:11434 2>/dev/null || echo "  (ollama not listening on 11434 — run setup.sh)"

echo
ok "Only '127.0.0.1:11434' or 'localhost:11434' is expected.  If Ollama is bound to 0.0.0.0, anyone on your network could reach it."
