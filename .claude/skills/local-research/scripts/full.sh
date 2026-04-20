#!/usr/bin/env bash
# End-to-end: plan -> gather -> synthesize.
set -e
HERE="$(dirname "${BASH_SOURCE[0]}")"
Q="$*"; [[ -z "$Q" ]] && Q="$(cat)"
[[ -z "$Q" ]] && { echo "Usage: full.sh <research question>"; exit 1; }

"$HERE/plan.sh" "$Q"
# Find the most recent research dir we just created
LATEST=$(ls -td "$(cd "$HERE/../../../.." && pwd)/.research/"*/ 2>/dev/null | head -1)
"$HERE/gather.sh"     "$LATEST/plan.md"
"$HERE/synthesize.sh" "$LATEST/gathered.md"
