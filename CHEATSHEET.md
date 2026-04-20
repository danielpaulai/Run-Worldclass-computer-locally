# Cheat Sheet — Run a World-Class AI on Your Laptop

**Repo:** github.com/danielpaulai/Run-Worldclass-computer-locally

## The 3-command setup

```bash
git clone https://github.com/danielpaulai/Run-Worldclass-computer-locally.git
cd Run-Worldclass-computer-locally
./preflight.sh && ./setup.sh     # Windows: .\preflight.ps1 ; .\setup.ps1
```

## Daily use

| Action | Command |
|---|---|
| Start a chat | `./chat.sh` (`.\chat.ps1`) |
| Exit the chat | `/bye` |
| List your models | `ollama list` |
| Pull a different model | `ollama pull <name>` |
| Remove a model | `ollama rm <name>` |
| Restart Ollama (macOS) | `brew services restart ollama` |
| Restart Ollama (Linux) | `sudo systemctl restart ollama` |
| Uninstall everything | `./uninstall.sh` |

## Model picker

| RAM | Model | Size | Good for |
|---|---|---|---|
| 8 GB | `llama3.2:3b` | 2 GB | General chat, fast |
| 16 GB | `qwen2.5:7b` | 5 GB | Best all-rounder |
| 16 GB | `qwen2.5-coder:7b` | 5 GB | Code-focused |
| 32 GB | `qwen2.5:14b` | 9 GB | Noticeably smarter |
| 32 GB | `deepseek-r1:14b` | 9 GB | Reasoning |
| 64 GB+ | `gpt-oss:20b` | 13 GB | Near-frontier |

## The 5 skills (talk to Claude Code inside the repo)

| Say this | What happens |
|---|---|
| "Ask my local model X" | Routes to local, returns answer |
| "Summarize this file privately" | Local summary, nothing uploaded |
| "Benchmark my model" | Tokens/sec + time to first token |
| "Compare local vs cloud on X" | Side-by-side answers |
| "Switch to <model>" | Changes active model |

## Troubleshooting keys

| Symptom | Fix |
|---|---|
| `command not found: ollama` | Re-run `./setup.sh` |
| Chat hangs, no response | Restart service (see table above) |
| "model not found" | `ollama pull <model>` |
| Out of RAM / swapping | Switch to a smaller model via swap-model skill |
| First response is slow | Normal — model loading. Subsequent responses are fast. |

## Privacy checks

- Your traffic: **`lsof -i :11434`** — only Ollama listening on localhost.
- Pull the ethernet / turn off wifi — your chat still works.
- All model files: **`~/.ollama/models/`**
