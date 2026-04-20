#!/usr/bin/env bash
#
# Fully remove Ollama, downloaded models, and this tool's state.
#
set -e

read -r -p "This will uninstall Ollama and delete all downloaded models. Continue? [y/N] " ans
case "$ans" in
  y|Y|yes|YES) ;;
  *) echo "Cancelled."; exit 0 ;;
esac

brew services stop ollama 2>/dev/null || true
brew uninstall ollama    2>/dev/null || true
rm -rf "$HOME/.ollama"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rm -f "$SCRIPT_DIR/.selected-model"

echo "Done. Ollama and its models have been removed."
