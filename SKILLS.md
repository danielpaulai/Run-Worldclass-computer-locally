# Skills Bundled With This Repo

This repo ships five Claude Code skills that let students actually *use* their local AI during the session. They all sit in `.claude/skills/` and activate automatically when Claude Code runs in this repo.

## What each skill does

| Skill | What it does | When to use |
|---|---|---|
| **local-chat** | Routes a prompt to the local model and returns the response | First-time "hello" — confirms local AI is working |
| **local-file-summary** | Summarizes a file using the local model, never uploading it | Demoing privacy — "summarize this confidential doc" |
| **local-benchmark** | Measures tokens/sec and time-to-first-token on their hardware | "How fast does my laptop run this?" |
| **swap-model** | Lists installed models, pulls new ones, switches the active one | "Try a smaller/bigger model" |
| **local-compare** | Runs a prompt through both local and cloud, shows both answers | Honest quality comparison |

## How to trigger them

Students don't need to learn new commands. They just talk naturally to Claude Code. Each skill's description lists trigger phrases.

Examples:
- "Ask my local model what a transformer is." → `local-chat`
- "Summarize this file privately." → `local-file-summary`
- "How fast is my model running?" → `local-benchmark`
- "Try qwen2.5-coder instead." → `swap-model`
- "Compare local and cloud on this prompt." → `local-compare`

## Suggested session flow (teachers)

| Minute | Skill | What to demo |
|---|---|---|
| 0–12   | (setup) | Run `./preflight.sh`, then `./setup.sh` |
| 12–15  | `local-chat` | First conversation with the local model |
| 15–20  | `local-file-summary` | Summarize a sample "confidential" doc |
| 20–25  | `local-benchmark` | Each student shares their tokens/sec |
| 25–30  | `local-compare` | Side-by-side local vs cloud on a reasoning problem |
| 30–35  | `swap-model` | Try a different model, re-benchmark |
| 35–45  | Free exploration | Students invent their own prompts |

## Extending the set

Add a new skill by creating `.claude/skills/<name>/SKILL.md` with YAML frontmatter. Claude Code picks it up on the next run.

Starter template:
```markdown
---
name: your-skill
description: One sentence about what this does and when to trigger it. Include likely user phrases so the matcher finds it.
---

# Your Skill

Steps the model should take, written as clear instructions.
```

Good candidate additions for a follow-up session:
- **local-rag** — index a folder of notes, answer questions over them
- **local-translate** — translate offline (great for language classes)
- **local-image-caption** — vision models via Ollama (llava, moondream)
- **local-voice** — pair with `whisper.cpp` for offline voice-to-local-AI
- **model-quality-test** — run a canned set of evals against the installed model

## Technical note

All five skills shell out to `ollama run` directly. They do **not** try to route Claude Code through Ollama via `ANTHROPIC_BASE_URL` — that path requires a protocol translator (Ollama speaks its own format, Claude Code expects Anthropic's `/v1/messages`) and adds more failure modes than it's worth. Shelling out is boringly reliable.
