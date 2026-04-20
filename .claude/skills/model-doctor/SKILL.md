---
name: model-doctor
description: Self-diagnose and repair the local-AI stack. Five actions — health (end-to-end check of Ollama + active model), restart (cross-platform service restart), clear-cache (drop in-memory state), repair (re-pull current model if corrupted), logs (tail Ollama logs). Use when the user says "something's broken", "chat is hanging", "model is acting weird", "fix ollama", "health check".
---

# Model Doctor — diagnose and heal

| Action | Does |
|---|---|
| `health` | Checks: Ollama installed, running, model present, responds to a test prompt |
| `restart` | Restarts Ollama via the right method for your OS |
| `clear-cache` | Drops loaded models from memory (next prompt reloads fresh) |
| `repair` | Re-pulls the active model (fixes corruption) |
| `logs [N]` | Shows last N lines of Ollama logs (default 50) |

## Examples

```bash
./ai model-doctor health
./ai model-doctor restart
./ai model-doctor clear-cache
./ai model-doctor repair
./ai model-doctor logs 100
```
