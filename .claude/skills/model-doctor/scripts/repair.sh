#!/usr/bin/env bash
# Re-pull the active model to fix corruption.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
MODEL=$(get_model)
say "Re-pulling $MODEL to verify + repair..."
ollama pull "$MODEL"
ok "$MODEL repaired (or verified clean)."
