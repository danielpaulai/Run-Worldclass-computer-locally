#!/usr/bin/env bash
# Walk through a plan, confirming each step.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
PLAN="$1"; [[ -f "$PLAN" ]] || die "Plan not found: $PLAN"
WORK="$(dirname "$PLAN")"
LOG="$WORK/execution.log"
: > "$LOG"

# Naive block splitter — each step starts with '### Step'
python3 - "$PLAN" "$WORK" "$LOG" <<'PY'
import sys, os, re, subprocess

plan_path, work, log_path = sys.argv[1:4]
text = open(plan_path).read()
steps = re.split(r"(?=^### Step)", text, flags=re.MULTILINE)
steps = [s.strip() for s in steps if s.strip().startswith("### Step")]

DANGEROUS = [" rm ", " sudo", "curl|sh", "curl | sh", "ssh ", "mkfs", ":(){", "dd if="]

def safe(cmd):
    low = " "+cmd.lower()+" "
    return not any(bad in low for bad in DANGEROUS)

for i, s in enumerate(steps, 1):
    print("\n"+"="*60)
    print(s)
    print("="*60)
    ans = input(f"\nExecute step {i}? [y/N/q] ").strip().lower()
    if ans == "q": print("Aborted."); break
    if ans != "y": print("Skipped."); continue

    m_type = re.search(r"^TYPE:\s*(\w+)", s, re.MULTILINE)
    if not m_type:
        print("  (no TYPE — skipping)"); continue
    t = m_type.group(1).lower()

    if t == "shell":
        m_cmd = re.search(r"^COMMAND:\s*(.+)$", s, re.MULTILINE)
        if not m_cmd: print("  (no COMMAND — skipping)"); continue
        cmd = m_cmd.group(1).strip()
        if not safe(cmd):
            print(f"  [BLOCKED] Unsafe command: {cmd}")
            open(log_path,"a").write(f"step {i}: BLOCKED {cmd}\n")
            continue
        print(f"  $ {cmd}")
        r = subprocess.run(cmd, shell=True, cwd=work, capture_output=True, text=True)
        print(r.stdout)
        if r.stderr: print("[stderr]", r.stderr)
        open(log_path,"a").write(f"step {i}: ran {cmd}\n{r.stdout}\n")
    elif t == "write":
        m_file = re.search(r"^FILE:\s*(.+)$", s, re.MULTILINE)
        m_body = re.search(r"CONTENT_START\n(.*?)\nCONTENT_END", s, re.DOTALL)
        if not m_file or not m_body: print("  (malformed write step — skipping)"); continue
        path = os.path.join(work, m_file.group(1).strip())
        os.makedirs(os.path.dirname(path) or ".", exist_ok=True)
        open(path,"w").write(m_body.group(1))
        print(f"  wrote {path}")
        open(log_path,"a").write(f"step {i}: wrote {path}\n")
    else:
        print(f"  unknown type '{t}' — skipping")
PY

echo
ok "Execution log: $LOG"
