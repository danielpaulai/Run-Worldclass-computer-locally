---
name: privacy-audit
description: Verify that the local-AI stack is actually private — no data leaving the machine. Four actions — listeners (what's listening on network ports), network-watch (watch outbound traffic during a chat), check (full audit combining everything), report (generate a shareable privacy report). Use when the user asks "is it really private", "verify local", "privacy check", "is anything being sent out".
---

# Privacy Audit — prove nothing's leaving your machine

| Action | Does |
|---|---|
| `listeners` | Shows which processes are listening on which ports |
| `network-watch <seconds>` | Watches outbound connections while you chat |
| `check` | Full audit: listeners + recent Ollama traffic + model file locations |
| `report` | Generates a markdown privacy report you can share |

## Examples

```bash
./ai privacy-audit listeners
./ai privacy-audit network-watch 30
./ai privacy-audit check
./ai privacy-audit report > PRIVACY-REPORT.md
```
