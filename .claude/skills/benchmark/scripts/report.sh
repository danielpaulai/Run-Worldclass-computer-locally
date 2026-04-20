#!/usr/bin/env bash
# Print the most recent benchmark report.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ROOT=$(repo_root)
LATEST=$(ls -td "$ROOT"/.benchmarks/*/ 2>/dev/null | head -1)
[[ -z "$LATEST" ]] && die "No benchmark reports yet.  Run ./ai benchmark full first."
cat "$LATEST/report.md"
echo
ok "Report from: $LATEST"
