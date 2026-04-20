#!/usr/bin/env bash
# Add docstrings / inline comments to a file.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
FILE="$1"; [[ -f "$FILE" ]] || die "File not found: $FILE"
MODEL=$(get_model)
{ echo "Add documentation to the code below:"; \
  echo "  - Module/file-level doc at the top"; \
  echo "  - Docstring for every public function/class (use idiomatic format for the language)"; \
  echo "  - One-line inline comment for any non-obvious line"; \
  echo "Preserve all code exactly. Only add, don't change logic."; \
  echo "Output the entire file, ready to paste back."; \
  echo; echo '```'; cat "$FILE"; echo '```'; } \
  | ollama run "$MODEL"
