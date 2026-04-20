#!/usr/bin/env bash
# Run a single prompt through the local model, then (when invoked via Claude Code)
# the cloud-side response is produced by the main session.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
PROMPT="$*"; [[ -z "$PROMPT" ]] && PROMPT="$(cat)"

echo
echo "## Local  ·  $MODEL"
echo
START=$(date +%s)
echo "$PROMPT" | ollama run "$MODEL"
END=$(date +%s)
echo
ok "Local ran in $((END-START))s, entirely offline."
echo
echo "---"
echo "(When invoked through Claude Code, generate the cloud response directly after this output for a side-by-side comparison.)"
