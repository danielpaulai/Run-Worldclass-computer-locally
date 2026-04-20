#!/usr/bin/env bash
# End-to-end health check.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"

ok_count=0; fail_count=0
check() {
  if eval "$2" >/dev/null 2>&1; then ok "$1"; ok_count=$((ok_count+1))
  else err "$1"; fail_count=$((fail_count+1)); fi
}

echo
say "Health check..."
check "Ollama command available"      "command -v ollama"
check "Ollama service responding"     "curl -s --max-time 3 http://localhost:11434/api/version"
check ".selected-model exists"        "[[ -f \"$(repo_root)/.selected-model\" ]]"

MODEL=""
[[ -f "$(repo_root)/.selected-model" ]] && MODEL=$(cat "$(repo_root)/.selected-model")

if [[ -n "$MODEL" ]]; then
  check "Active model '$MODEL' installed" "ollama list | awk 'NR>1 {print \$1}' | grep -qx \"$MODEL\""
  check "Model responds to test prompt"   "echo hi | timeout 30 ollama run \"$MODEL\""
fi

echo
if (( fail_count == 0 )); then
  ok "All $ok_count checks passed."
else
  err "$fail_count check(s) failed.  Try:  ./ai model-doctor restart"
fi
