#!/usr/bin/env bash
# Register a workflow file under a name.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
NAME="$1"; FILE="$2"
[[ -n "$NAME" && -f "$FILE" ]] || die "Usage: save.sh <name> <workflow.yaml>"
ROOT=$(repo_root); DIR="$ROOT/.workflows"; mkdir -p "$DIR"
cp "$FILE" "$DIR/$NAME.yaml"
ok "Saved workflow '$NAME' to $DIR/$NAME.yaml"
