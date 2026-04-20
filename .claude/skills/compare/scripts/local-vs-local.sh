#!/usr/bin/env bash
# Run the same prompt through two installed models and show them side by side.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
A="$1"; B="$2"; shift 2 || die "Usage: local-vs-local.sh <modelA> <modelB> <prompt>"
PROMPT="$*"

echo
echo "## $A"
echo
echo "$PROMPT" | ollama run "$A"
echo
echo "## $B"
echo
echo "$PROMPT" | ollama run "$B"
