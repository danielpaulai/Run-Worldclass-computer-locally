# Instructions for Claude Code

This repo installs a local AI on the user's machine using Ollama. When a user asks you to set it up:

## Do this

1. Detect the user's OS.
   - macOS or Linux → run `./setup.sh`
   - Windows → run `.\setup.ps1` in PowerShell
2. Show the script output as it progresses so the user can see what's happening.
3. When setup finishes, tell them two things:
   - They can chat with the model by running `./chat.sh` (or `.\chat.ps1` on Windows)
   - Everything is fully local — nothing leaves their machine
4. Optionally, offer to run the chat script so they can try it. Warn that the first token may take a few seconds while the model loads into memory.

## Do NOT do this

- Do **not** try to route Claude Code itself through Ollama via `ANTHROPIC_BASE_URL`. Claude Code speaks Anthropic's `/v1/messages` format; Ollama doesn't. Bridging them needs a translator proxy and adds failure modes. This repo is deliberately a standalone local-AI setup, not a Claude Code backend swap.
- Do not pull giant models (e.g. `qwen3-coder-next`, `llama3.1:405b`) unless the user explicitly asks. The setup script already picks a model sized to their RAM.

## Troubleshooting

If setup fails:

- `curl http://localhost:11434/api/version` — should return a JSON version. If it errors, Ollama isn't running:
  - macOS: `brew services restart ollama`
  - Linux: `sudo systemctl restart ollama` (or `ollama serve &`)
  - Windows: `Start-Process ollama -ArgumentList serve -WindowStyle Hidden`
- `ollama list` — confirms which models are downloaded.
- Free disk space: models are 2–13 GB.
- Re-run the setup script. It's idempotent and safe to re-run.

## Files in this repo

| File | Purpose |
|---|---|
| `setup.sh` / `.ps1`     | OS-specific installers |
| `preflight.sh` / `.ps1` | Pre-session readiness check |
| `chat.sh` / `.ps1`      | Launch chat |
| `uninstall.sh` / `.ps1` | Clean removal |
| `ai`                     | Top-level skill dispatcher: `./ai <skill> <action> [args]` |
| `.claude/skills/`        | 15 layered skills (see SKILLS.md) |
| `.claude/skills/lib/common.sh` | Shared helpers every skill sources |
| `.selected-model`        | Active model. Created by setup, read by every skill. Git-ignored. |

## The 15 skills

Every skill is a folder with a `SKILL.md` (dispatch instructions) and a `scripts/` directory. When the user asks to do something, pick the matching skill and run `./ai <skill> <action> [args]` or `bash .claude/skills/<skill>/scripts/<action>.sh [args]`.

Full list: see [SKILLS.md](./SKILLS.md). Quick grouping:

- **Chat:** `local-ai` (ask / session / persona / creative / precise / pipe)
- **Understand content:** `summarize`, `local-rag`, `local-research`
- **Make things:** `local-code`, `local-writer`, `local-agent`, `local-workflow`
- **Learn:** `local-tutor`, `local-journal`
- **Ops & trust:** `model-manager`, `benchmark`, `compare`, `privacy-audit`, `model-doctor`

## Invocation etiquette

- Always confirm which skill/action best matches the user's request — don't guess if it's ambiguous.
- For destructive actions (`model-manager remove`, `uninstall.sh`, `local-agent run`), show the user what will happen and ask before executing.
- When a skill has multiple relevant actions, pick the most specific one. E.g., "summarize this as bullets" → `summarize bullets`, not `summarize any`.
- If a skill's script fails with a missing dep (pdftotext, pandoc, pyyaml), surface the install command clearly.
