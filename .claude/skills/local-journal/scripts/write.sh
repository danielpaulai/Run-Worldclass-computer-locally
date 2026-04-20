#!/usr/bin/env bash
# Open today's journal entry in $EDITOR.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ROOT=$(repo_root); DIR="$ROOT/.journal"; mkdir -p "$DIR"
FILE="$DIR/$(date +%Y-%m-%d).md"
PROMPT="$*"

if [[ ! -f "$FILE" ]]; then
  {
    echo "# $(date +"%A, %B %-d, %Y")"
    echo
    if [[ -n "$PROMPT" ]]; then echo "> $PROMPT"; echo; fi
    echo
  } > "$FILE"
fi

"${EDITOR:-nano}" "$FILE"
ok "Saved: $FILE"
