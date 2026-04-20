#!/usr/bin/env bash
# Install a model from the Ollama registry.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
M="$1"; [[ -n "$M" ]] || die "Usage: install.sh <model>"
say "Pulling $M..."
ollama pull "$M"
ok "Installed: $M"
echo "To make it active:  ./ai model-manager switch $M"
