#!/usr/bin/env bash
#
# Fully remove Ollama, downloaded models, and this tool's state.
# macOS and Linux.
#
set -e

read -r -p "This will uninstall Ollama and delete all downloaded models. Continue? [y/N] " ans
case "$ans" in
  y|Y|yes|YES) ;;
  *) echo "Cancelled."; exit 0 ;;
esac

case "$(uname -s)" in
  Darwin)
    brew services stop ollama 2>/dev/null || true
    brew uninstall ollama     2>/dev/null || true
    ;;
  Linux)
    sudo systemctl stop    ollama 2>/dev/null || true
    sudo systemctl disable ollama 2>/dev/null || true
    sudo rm -f /etc/systemd/system/ollama.service
    sudo rm -f /usr/local/bin/ollama /usr/bin/ollama
    sudo userdel  ollama 2>/dev/null || true
    sudo groupdel ollama 2>/dev/null || true
    ;;
  *) echo "Unsupported OS for uninstall."; exit 1 ;;
esac

rm -rf "$HOME/.ollama"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
rm -f "$SCRIPT_DIR/.selected-model"

echo "Done. Ollama and its models have been removed."
