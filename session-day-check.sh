#!/usr/bin/env bash
#
# session-day-check.sh — Run this 10 minutes before your live session starts.
#
# It does three things, in order:
#   1. Preflight  (is the hardware OK, model installed, Ollama alive)
#   2. Smoke test (do all the skills actually produce output right now?)
#   3. Warm-up benchmark (first-token latency + tokens/sec on the active model)
#
# Green banner at the end = you're safe to start.
# Red banner = fix what's flagged before class.
#
set -u

cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

bold()   { printf "\033[1m%s\033[0m\n" "$1"; }
green()  { printf "\033[1;32m%s\033[0m" "$1"; }
yellow() { printf "\033[1;33m%s\033[0m" "$1"; }
red()    { printf "\033[1;31m%s\033[0m" "$1"; }
hr()     { printf '%*s\n' 60 '' | tr ' ' '='; }

BLOCKERS=0
WARNINGS=0

# ---------- 1. Preflight ----------
echo
hr
bold "  1 / 3  ·  Preflight check"
hr
echo
if ./preflight.sh >/tmp/sdc-preflight.out 2>&1; then
  echo "  $(green "PASS")  preflight clean"
else
  echo "  $(red "FAIL")  preflight found blockers"
  echo
  sed -n '/\[NO\]\|\[!!\]/p' /tmp/sdc-preflight.out | sed 's/^/      /'
  BLOCKERS=$((BLOCKERS+1))
fi

# ---------- 2. Smoke test ----------
echo
hr
bold "  2 / 3  ·  Smoke test (15 skills)"
hr
echo
if ./tests/smoke.sh --fast >/tmp/sdc-smoke.out 2>&1; then
  PASS_LINE=$(grep -E 'passed.*failed.*skipped' /tmp/sdc-smoke.out | tail -1 | tr -d '\033' | sed 's/\[[0-9;]*m//g')
  echo "  $(green "PASS")  $PASS_LINE"
else
  FAILS=$(grep -c "FAIL\|EMPTY" /tmp/sdc-smoke.out || echo 0)
  echo "  $(red "FAIL")  $FAILS skill(s) broken"
  echo
  grep -E "FAIL|EMPTY" /tmp/sdc-smoke.out | head -10 | sed 's/^/      /'
  BLOCKERS=$((BLOCKERS+1))
fi

# ---------- 3. Warm-up benchmark ----------
echo
hr
bold "  3 / 3  ·  Warm-up benchmark"
hr
echo
if ! curl -s http://localhost:11434/api/version >/dev/null 2>&1; then
  echo "  $(red "FAIL")  Ollama not reachable at localhost:11434"
  BLOCKERS=$((BLOCKERS+1))
else
  MODEL=$(cat .selected-model 2>/dev/null)
  [[ -z "$MODEL" ]] && { echo "  $(red "FAIL")  no .selected-model"; BLOCKERS=$((BLOCKERS+1)); MODEL=""; }

  if [[ -n "$MODEL" ]]; then
    echo "  Loading $MODEL into RAM (first request always slow)..."
    # Use a dedicated helper file — avoids shell-quoting pitfalls with heredocs
    # containing braces/colons/commas that zsh or bash can mangle.
    read -r RATE WALL TOKENS < <(MODEL="$MODEL" python3 .claude/skills/lib/bench.py)

    if [[ -z "${RATE:-}" || "$RATE" == "0" || "$RATE" == "0.0" ]]; then
      echo "  $(red "FAIL")  Benchmark returned no tokens — Ollama unreachable or model broken"
      BLOCKERS=$((BLOCKERS+1))
    else
      echo "  $(green "PASS")  ${RATE} tokens/sec  ·  ${WALL}s wall time  ·  ${TOKENS} tokens produced"
      # Flag slow models (<15 tok/sec = laggy demo)
      if awk -v r="$RATE" 'BEGIN{exit !(r+0 < 15)}'; then
        echo "  $(yellow "WARN")  Under 15 tok/sec — demos will feel laggy. Consider a smaller model."
        WARNINGS=$((WARNINGS+1))
      fi
    fi
  fi
fi

# ---------- Verdict ----------
echo
hr
if (( BLOCKERS > 0 )); then
  bold "$(red "  NOT READY.")  $BLOCKERS blocker(s) above — fix before class."
  hr
  exit 1
elif (( WARNINGS > 0 )); then
  bold "$(yellow "  READY WITH WARNINGS.")  Session will work, but heads-up on $WARNINGS item(s)."
  hr
  exit 0
else
  bold "$(green "  READY.")  All three checks passed — you can start the session."
  hr
  exit 0
fi
