#!/usr/bin/env bash
# Remove a model (asks for confirmation).
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
M="$1"; [[ -n "$M" ]] || die "Usage: remove.sh <model>"

ROOT=$(repo_root)
if [[ -f "$ROOT/.selected-model" && "$(cat "$ROOT/.selected-model")" == "$M" ]]; then
  warn "'$M' is the active model.  Switch to another first:  ./ai model-manager switch <other>"
  exit 1
fi

read -r -p "Remove $M?  [y/N] " ans
case "$ans" in y|Y|yes|YES) ;; *) echo "Cancelled."; exit 0 ;; esac
ollama rm "$M"
ok "Removed: $M"
