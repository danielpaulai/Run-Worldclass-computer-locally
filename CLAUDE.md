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
| `setup.sh`     | Installer for macOS and Linux |
| `setup.ps1`    | Installer for Windows |
| `chat.sh`      | Launch chat (macOS / Linux) |
| `chat.ps1`     | Launch chat (Windows) |
| `uninstall.sh` | Remove Ollama and models (macOS / Linux) |
| `uninstall.ps1`| Remove Ollama and models (Windows) |
| `.selected-model` | Created by setup, read by chat. Git-ignored. |
