#!/usr/bin/env bash
# Generate a shareable markdown privacy report.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
HERE="$(dirname "${BASH_SOURCE[0]}")"

{
  echo "# Local-AI Privacy Report"
  echo
  echo "Generated: $(date)"
  echo "Host: $(hostname)"
  echo "OS: $(uname -s) $(uname -r)"
  echo
  echo "## 1. Network listeners"
  echo '```'
  "$HERE/listeners.sh" 2>&1 | sed 's/\x1b\[[0-9;]*m//g'
  echo '```'
  echo
  echo "## 2. Ollama binding"
  echo '```'
  lsof -nP -iTCP:11434 2>/dev/null || echo "(nothing)"
  echo '```'
  echo
  echo "## 3. Environment overrides"
  echo '```'
  env | grep -iE "^(OLLAMA|ANTHROPIC)_" || echo "(none set)"
  echo '```'
  echo
  echo "## 4. Model storage"
  echo '```'
  du -sh "$HOME/.ollama" 2>/dev/null || echo "(no model dir)"
  echo '```'
  echo
  echo "## Interpretation"
  echo
  echo "- Ollama should be bound to **127.0.0.1** or **localhost** only. A bind to 0.0.0.0 means it's reachable from your local network."
  echo "- No \`ANTHROPIC_BASE_URL\` or similar env var should point away from localhost."
  echo "- Model files live on local disk under \`~/.ollama\`."
  echo "- A reliable final check: turn off wifi, re-run your chat — if it still works, nothing needed the network."
}
