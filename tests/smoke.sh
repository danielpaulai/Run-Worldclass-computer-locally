#!/usr/bin/env bash
#
# Smoke test — runs one fast action from every skill, reports pass/fail.
# Exits non-zero if any skill is broken.
#
# Usage:  ./tests/smoke.sh
#         ./tests/smoke.sh --fast   (skip slow skills: benchmark full, rag ingest)
#
set -u

cd "$(dirname "${BASH_SOURCE[0]}")/.." || exit 1
SKIP_SLOW=0
[[ "${1:-}" == "--fast" ]] && SKIP_SLOW=1

PASS=0; FAIL=0; SKIP=0
PASSED=(); FAILED=(); SKIPPED=()

# Pick a working timeout command (macOS has neither `timeout` nor coreutils by default).
if command -v timeout  >/dev/null 2>&1; then TIMEOUT=(timeout 120)
elif command -v gtimeout >/dev/null 2>&1; then TIMEOUT=(gtimeout 120)
else TIMEOUT=()    # no timeout available; rely on the test itself to finish
fi

run() {
  local name="$1"; shift
  printf "  %-40s " "$name"
  local tmp; tmp=$(mktemp)
  if "${TIMEOUT[@]+"${TIMEOUT[@]}"}" "$@" > "$tmp" 2>&1; then
    # Also require non-empty output — empty output means a silent failure
    if [[ -s "$tmp" ]]; then
      printf "\033[1;32mPASS\033[0m\n"
      PASS=$((PASS+1)); PASSED+=("$name")
    else
      printf "\033[1;33mEMPTY\033[0m\n"
      FAIL=$((FAIL+1)); FAILED+=("$name (ran but produced no output)")
    fi
  else
    printf "\033[1;31mFAIL\033[0m\n"
    FAIL=$((FAIL+1)); FAILED+=("$name")
    echo "    --- last 10 lines of output ---"
    tail -10 "$tmp" | sed 's/^/    /'
    echo "    --------------------------------"
  fi
  rm -f "$tmp"
}

skip() {
  local name="$1" reason="$2"
  printf "  %-40s \033[1;33mSKIP\033[0m  (%s)\n" "$name" "$reason"
  SKIP=$((SKIP+1)); SKIPPED+=("$name")
}

# --- preflight ---
echo
echo "=========================================="
echo "  Smoke test — 15 skills"
echo "=========================================="
echo

if ! curl -s --max-time 2 http://localhost:11434/api/version >/dev/null 2>&1; then
  echo "  Ollama is not running.  Start it:  brew services start ollama"
  exit 1
fi

if [[ ! -f .selected-model ]]; then
  echo "  No .selected-model file.  Run  ./setup.sh  first."
  exit 1
fi

MODEL=$(cat .selected-model)
echo "  Model: $MODEL"
echo

# --- tests ---
run "local-ai · ask"         bash -c 'echo "say hi in 3 words" | ./ai local-ai ask'
run "local-ai · precise"     bash -c 'echo "2+2=?" | ./ai local-ai precise'
run "local-ai · persona"     ./ai local-ai persona engineer "one-line def of recursion"

run "summarize · tldr"       ./ai summarize tldr README.md
run "summarize · bullets"    ./ai summarize bullets chat.sh

run "local-code · explain"   ./ai local-code explain chat.sh
run "local-code · review"    ./ai local-code review chat.sh

run "local-writer · draft"   bash -c 'echo "one-line email acknowledging receipt" | ./ai local-writer draft'
run "local-writer · outline" bash -c 'echo "benefits of local AI" | ./ai local-writer outline'

run "local-tutor · explain"  ./ai local-tutor explain "what is HTTP"

if (( SKIP_SLOW == 0 )); then
  run "benchmark · quick"    ./ai benchmark quick
else
  skip "benchmark · quick"  "--fast mode"
fi

run "model-manager · list"   ./ai model-manager list
run "model-manager · recommend" ./ai model-manager recommend general
run "model-manager · disk-audit" ./ai model-manager disk-audit

run "model-doctor · health"  ./ai model-doctor health
run "privacy-audit · listeners" ./ai privacy-audit listeners

run "compare · rubric"       ./ai compare rubric "What is the speed of light?"

skip "local-rag · ingest"         "needs folder argument"
skip "local-rag · query"          "requires prior ingest"
skip "local-research · full"      "slow (~60s)"
skip "local-agent · plan"         "requires goal argument"
skip "local-agent · run"          "interactive, requires plan"
skip "local-journal · write"      "interactive (opens editor)"
skip "local-workflow · run"       "requires saved workflow + args"

# --- summary ---
echo
echo "=========================================="
printf "  %s passed  ·  %s failed  ·  %s skipped\n" "$PASS" "$FAIL" "$SKIP"
echo "=========================================="
echo

if (( FAIL > 0 )); then
  echo "Failed:"
  printf '    - %s\n' "${FAILED[@]}"
  exit 1
fi
echo "All tested skills pass."
