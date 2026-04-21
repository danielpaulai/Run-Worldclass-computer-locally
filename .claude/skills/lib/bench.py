#!/usr/bin/env python3
# Tiny benchmark helper — warms the model, runs a single measured call,
# prints "RATE WALL TOKENS" to stdout.  Called by session-day-check.sh.
#
# Env: MODEL (the model name to benchmark)
import json, os, sys, time, urllib.request

model = os.environ.get("MODEL", "").strip()
if not model:
    print("0 0 0")
    sys.exit(0)

URL = "http://localhost:11434/api/generate"

def call(prompt):
    payload = {"model": model, "prompt": prompt, "stream": False}
    body = json.dumps(payload).encode()
    req = urllib.request.Request(
        URL, data=body, headers={"Content-Type": "application/json"}
    )
    return json.loads(urllib.request.urlopen(req, timeout=600).read())

# Warm-up (loads model into RAM) — not measured.
try:
    call("hi")
except Exception as e:
    print(f"0 0 0", file=sys.stderr)
    print(f"benchmark warmup failed: {e}", file=sys.stderr)
    sys.exit(1)

# Measured call.
t0 = time.time()
try:
    d = call("Write 60 words on why local AI matters for small businesses.")
except Exception as e:
    print(f"0 0 0", file=sys.stderr)
    print(f"benchmark measured call failed: {e}", file=sys.stderr)
    sys.exit(1)
wall = time.time() - t0

tokens  = d.get("eval_count", 0)
eval_ns = d.get("eval_duration", 1) or 1
rate    = tokens / (eval_ns / 1e9)

print(f"{rate:.1f} {wall:.1f} {tokens}")
