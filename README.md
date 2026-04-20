# Run a World-Class AI on Your Laptop

A one-command setup for running a serious AI model fully on your own Mac. No cloud, no API keys, no subscription. Your data never leaves your machine.

## What you get

- A local AI chat running on your laptop
- A model sized to match your hardware (picked automatically)
- Three tiny scripts: `setup.sh`, `chat.sh`, `uninstall.sh`

## Requirements

- macOS (Apple Silicon or Intel)
- 8 GB RAM minimum (16 GB+ recommended)
- ~5–15 GB of free disk space for the model

## Quick start

```bash
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally.git
cd Run-Worldclass-computer-locally
./setup.sh
./chat.sh
```

That's it. First run downloads the model (one-time). After that, `./chat.sh` is instant.

## What `setup.sh` does

1. Installs Homebrew if it's missing
2. Installs Ollama (the local AI runtime)
3. Starts Ollama as a background service
4. Detects your RAM and picks the right model
5. Downloads the model
6. Prints next steps

## Model chosen automatically

| Your Mac's RAM | Model installed | Size on disk |
|---|---|---|
| 8 GB  | `llama3.2:3b`  | ~2 GB  |
| 16 GB | `qwen2.5:7b`   | ~5 GB  |
| 32 GB | `qwen2.5:14b`  | ~9 GB  |
| 64 GB+| `gpt-oss:20b`  | ~13 GB |

You can always pull a different model manually: `ollama pull <model>`.

## Chatting

```bash
./chat.sh
```

Inside the chat:
- Type messages, hit enter.
- `/bye` exits.
- `/?` shows all commands.

## Letting Claude Code drive the install

If you use [Claude Code](https://claude.com/claude-code), just point it at this repo:

```
Set up this repo on my machine: https://github.com/danielpaulai/Run-Worldclass-computer-locally
```

Claude Code will read `CLAUDE.md` and run the setup for you.

## Uninstall

```bash
./uninstall.sh
```

Removes Ollama and every downloaded model.

## FAQ

**Why Ollama and not Claude Code against a local model?**
Claude Code speaks Anthropic's API format. Ollama speaks its own. Bridging the two needs a proxy and adds complexity with no real benefit. This setup keeps things simple: one runtime, one model, one command.

**Why these specific models?**
They're all open-weight, strong at general and coding tasks, and sized to run well on consumer Macs. You can swap any of them.

**Does my data leave my computer?**
No. Everything runs locally. Ollama listens only on `localhost:11434`.
