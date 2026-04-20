# Instructions for Claude Code

This repo installs a local AI on the user's Mac using Ollama. When a user opens this repo and asks you to set it up:

## Do this

1. Confirm the user is on macOS. If not, tell them this installer is macOS-only for now.
2. Run `./setup.sh` and show them the output as it progresses.
3. When setup finishes, tell them two things:
   - They can chat with the model by running `./chat.sh` in their terminal
   - The chat is fully local — nothing leaves their machine
4. If they want, offer to run `./chat.sh` so they can try it, but warn that the first token may take a few seconds while the model loads into memory.

## Do NOT do this

- Do **not** try to route Claude Code itself through Ollama via `ANTHROPIC_BASE_URL`. Claude Code speaks Anthropic's `/v1/messages` format; Ollama doesn't. Bridging them needs a translator proxy and adds failure modes. This repo is deliberately a standalone local-AI setup, not a Claude Code backend swap.
- Do not pull giant models (`qwen3-coder-next`, `llama3.1:405b`, etc.) unless the user explicitly asks. `setup.sh` already picks a model sized to their RAM.

## Troubleshooting

If setup fails:

- `curl http://localhost:11434/api/version` — should return a JSON version. If it errors, Ollama isn't running: `brew services restart ollama`.
- `ollama list` — confirms which models are downloaded.
- `df -h ~` — confirms enough free disk. Models are 2–13 GB.
- `brew services list | grep ollama` — confirms the service state.

If a model pull stalls, it's usually the network. `ollama pull <model>` resumes from where it left off.

## Files in this repo

- `setup.sh` — installs Homebrew (if needed), Ollama, and a model matched to the user's RAM.
- `chat.sh` — launches an interactive chat with the installed model.
- `uninstall.sh` — removes Ollama and all downloaded models.
- `.selected-model` — created by `setup.sh`, read by `chat.sh`. Git-ignored.
