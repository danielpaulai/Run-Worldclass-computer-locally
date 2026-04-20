#!/usr/bin/env bash
# Render the most recent benchmark run as a standalone HTML file.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ROOT=$(repo_root)
LATEST=$(ls -td "$ROOT"/.benchmarks/*/ 2>/dev/null | head -1)
[[ -z "$LATEST" ]] && die "No benchmark reports yet.  Run  ./ai benchmark full  first."

REPORT="$LATEST/report.md"
OUT="$LATEST/report.html"
MODEL=$(basename "$LATEST" | sed 's/^[0-9-]*-//; s|__|:|; s|__|/|')
GEN_DATE=$(date "+%Y-%m-%d %H:%M")

python3 - "$REPORT" "$OUT" "$MODEL" "$GEN_DATE" <<'PY'
import sys, re, html
md_path, out_path, model, gen_date = sys.argv[1:5]
md = open(md_path).read()

# Extract eval-rate samples
rates = [float(m.group(1)) for m in re.finditer(r"eval rate:\s*([\d.]+)\s*tokens/s", md)]
avg = sum(rates)/len(rates) if rates else 0

# Split into sections by "### <category>"
sections = re.split(r"(?=^### )", md, flags=re.MULTILINE)

body_parts = []
for s in sections:
    if not s.strip().startswith("### "): continue
    title = s.split("\n",1)[0].replace("### ","").strip()
    # Extract prompt, response, timings
    prompt = re.search(r"\*\*Prompt:\*\*\s*(.+)", s)
    prompt = prompt.group(1) if prompt else ""
    resp   = re.search(r"\*\*Response:\*\*\s*\n(.*?)\n\*\*Timings", s, re.DOTALL)
    resp   = resp.group(1).strip() if resp else ""
    timing = re.search(r"\*\*Timings:\*\*\s*\n(.*?)$", s, re.DOTALL)
    timing = timing.group(1).strip() if timing else ""
    body_parts.append(f"""
    <section class="card">
      <h3>{html.escape(title)}</h3>
      <div class="prompt"><span class="label">Prompt</span><p>{html.escape(prompt)}</p></div>
      <div class="response"><span class="label">Response</span><pre>{html.escape(resp)}</pre></div>
      <div class="timing"><span class="label">Timings</span><pre>{html.escape(timing)}</pre></div>
    </section>""")

html_out = f"""<!doctype html>
<html><head><meta charset="utf-8"><title>Local-AI Benchmark — {html.escape(model)}</title>
<style>
  body {{ font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Inter, sans-serif;
         max-width: 900px; margin: 2em auto; padding: 0 1em; color: #222; }}
  header {{ border-bottom: 2px solid #333; padding-bottom: 1em; margin-bottom: 2em; }}
  h1 {{ margin: 0; font-size: 1.8em; }}
  .meta {{ color: #666; font-size: 0.9em; }}
  .stats {{ display: grid; grid-template-columns: repeat(3, 1fr); gap: 1em; margin: 1em 0; }}
  .stat {{ background: #f7f7f9; padding: 1em; border-radius: 6px; border-left: 3px solid #3366cc; }}
  .stat .num {{ font-size: 2em; font-weight: 600; }}
  .stat .lbl {{ color: #666; font-size: 0.85em; text-transform: uppercase; }}
  .card {{ background: #fff; border: 1px solid #e4e4e8; border-radius: 8px; padding: 1.2em; margin-bottom: 1em; }}
  .card h3 {{ margin-top: 0; text-transform: capitalize; color: #3366cc; }}
  .label {{ display: block; font-size: 0.75em; text-transform: uppercase; color: #888; letter-spacing: 0.5px; margin-bottom: 0.3em; }}
  .prompt p {{ margin: 0 0 1em; font-style: italic; color: #444; }}
  pre {{ background: #f7f7f9; padding: 0.8em; border-radius: 4px; overflow-x: auto;
         font-size: 0.85em; white-space: pre-wrap; margin: 0 0 1em; }}
  footer {{ margin-top: 3em; padding-top: 1em; border-top: 1px solid #ddd;
            color: #888; font-size: 0.85em; text-align: center; }}
</style></head><body>
<header>
  <h1>Local-AI Benchmark</h1>
  <div class="meta">Model: <strong>{html.escape(model)}</strong> &middot; Generated: {html.escape(gen_date)}</div>
</header>

<div class="stats">
  <div class="stat"><div class="num">{avg:.1f}</div><div class="lbl">Avg tokens/sec</div></div>
  <div class="stat"><div class="num">{len(rates)}</div><div class="lbl">Prompts evaluated</div></div>
  <div class="stat"><div class="num">{max(rates) if rates else 0:.1f}</div><div class="lbl">Peak tokens/sec</div></div>
</div>

{''.join(body_parts)}

<footer>Run a World-Class AI on Your Laptop &middot; github.com/danielpaulai/Run-Worldclass-computer-locally</footer>
</body></html>
"""

open(out_path, "w").write(html_out)
print(f"Report written to {out_path}")
PY

ok "HTML report at: $OUT"
echo "Open with:  open $OUT   (mac)   /   xdg-open $OUT   (linux)"
