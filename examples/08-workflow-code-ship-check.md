# Example: Workflow `code-ship-check` end-to-end

**Model:** `qwen2.5:7b`
**Command:** `./ai local-workflow run code-ship-check chat.sh`
**Input:** `chat.sh` (the 30-line launcher in this repo)

## What the workflow does

Four chained steps, each a separate model call:

1. `./ai local-code review $1` — critique for bugs, style, edge cases
2. `./ai local-code test-gen $1` — generate shell tests
3. `./ai local-code doc $1` — add inline documentation
4. `./ai local-ai persona critic "…"` — takes all three outputs as context and delivers a ship/revise/block verdict

## Real output (condensed)

### Step 1 — Review

> The code is well-structured and generally solid. Minor issue: the script assumes Ollama will start within 2 seconds, which might not always be accurate. Suggested fix: add a loop to check if Ollama is running before proceeding.

*The model also produced a rewritten script with the fix applied.*

### Step 2 — Test-gen

The model wrote 5 shell test functions covering:
- Happy path (model launches)
- Missing `.selected-model` file
- Ollama not running on macOS
- Ollama not running on Linux with systemctl
- Ollama not running on Linux without systemctl

### Step 3 — Doc

The model rewrote `chat.sh` with inline comments explaining each section.

### Step 4 — Verdict (the new synthesis step)

> **Verdict: Revise.** The script lacks error handling for critical steps and assumes that `curl` will always be available on the system. Most importantly, the script does not handle cases where `ollama serve` fails to start, which could leave the user in an unknown state.
>
> **Concrete next step:** Add checks and fallback mechanisms for starting Ollama if it fails to start via the service manager or nohup method, ensuring the script can inform the user of any failures clearly.

## Teacher's note

**Quality: the workflow itself is the star here.** Each individual step is solid-but-not-stunning, but chaining them together produces something more than the parts.

Worth noting:

- The verdict step **integrated information from all three prior steps**. It's not just echoing Step 1's review — it noticed that the `curl` dependency wasn't mentioned anywhere in the docs step and flagged that as a gap. That's the value of workflows.
- The recommendation (add error handling for `ollama serve` failure) is a genuine improvement the script should get.
- The verdict is **"Revise"**, not "Ship" — the model didn't rubber-stamp. Good.

**Time:** ~90 seconds total for all 4 steps on `qwen2.5:7b`.

**This workflow is the template for anything ship-gated** — you can swap `$1` for any file the small-business owner is about to send, and the verdict step gives them one sharp recommendation instead of four separate walls of text to read.
