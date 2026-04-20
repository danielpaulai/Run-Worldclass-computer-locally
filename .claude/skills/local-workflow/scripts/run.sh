#!/usr/bin/env bash
# Execute a saved workflow.  Passes each step's output to the next as stdin.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
NAME="$1"; shift || true
ROOT=$(repo_root)
WF="$ROOT/.workflows/$NAME.yaml"
[[ -f "$WF" ]] || die "Workflow not found: $NAME.  Run  ./ai local-workflow list  to see saved ones."

python3 - "$WF" "$@" <<'PY'
import sys, subprocess, yaml, os
wf = yaml.safe_load(open(sys.argv[1]))
args = sys.argv[2:]
prev = ""
print(f"\n==> Workflow: {wf.get('name','(unnamed)')}\n")
for i, step in enumerate(wf.get("steps", []), 1):
    name = step.get("name", f"step-{i}")
    cmd = step["run"]
    use_prev = step.get("input") == "${previous}"
    print(f"--- Step {i}: {name} ---")
    print(f"$ {cmd}")
    r = subprocess.run(cmd, shell=True, input=prev if use_prev else None,
                       capture_output=True, text=True)
    print(r.stdout)
    if r.stderr: print("[stderr]", r.stderr, file=sys.stderr)
    prev = r.stdout
PY

ok "Workflow complete."
