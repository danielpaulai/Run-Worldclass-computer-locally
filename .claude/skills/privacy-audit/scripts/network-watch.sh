#!/usr/bin/env bash
# Watch outbound connections from Ollama for N seconds (default 30).
# Proves chat doesn't leave the machine.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
SECS="${1:-30}"

say "Watching Ollama's outbound connections for ${SECS}s..."
echo "Now open another terminal and do a chat:  ./chat.sh"
echo

SEEN=$(mktemp); trap 'rm -f "$SEEN"' EXIT

END=$(( $(date +%s) + SECS ))
while (( $(date +%s) < END )); do
  lsof -nP -iTCP -a -c ollama 2>/dev/null \
    | awk 'NR>1 && /->/ {print $9}' \
    | sort -u >> "$SEEN"
  sleep 1
done

echo
UNIQUE=$(sort -u "$SEEN" | grep -v '^$' || true)
if [[ -z "$UNIQUE" ]]; then
  ok "No outbound connections from Ollama during the watch window."
else
  say "Outbound connections observed:"
  echo "$UNIQUE"
  echo
  warn "Anything other than localhost / 127.0.0.1 is worth investigating."
fi
