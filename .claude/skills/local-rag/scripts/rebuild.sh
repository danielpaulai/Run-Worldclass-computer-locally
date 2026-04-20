#!/usr/bin/env bash
# Re-index the last-ingested folder.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ROOT=$(repo_root)
FOLDER_FILE="$ROOT/.rag/folder"
[[ -f "$FOLDER_FILE" ]] || die "No previous ingest found.  Run ingest first."
FOLDER=$(cat "$FOLDER_FILE")
exec "$(dirname "${BASH_SOURCE[0]}")/ingest.sh" "$FOLDER"
