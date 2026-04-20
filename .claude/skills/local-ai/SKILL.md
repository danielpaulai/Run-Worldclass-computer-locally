---
name: local-ai
description: The core conversation engine for the local model. Six layered modes — ask (one-shot), session (multi-turn with history), persona (apply engineer/writer/tutor/critic/socratic), creative (high temperature), precise (low temperature), and pipe (stream stdin through the model). Use whenever the user wants to chat with their local AI, tell it to "be like a senior engineer", have a back-and-forth conversation, or run something creative vs. deterministic. Trigger phrases - "ask local", "my local AI", "use my local model", "offline", "private", "as a persona", "multi-turn", "continue the conversation", "be more creative", "be more precise", "pipe through local".
---

# Local AI — core conversation engine

The main way to talk to the locally-installed model. Six distinct modes, each a separate script under `scripts/`:

| Action | When to use |
|---|---|
| `ask <prompt>` | One-shot question, no history |
| `session [name]` | Multi-turn conversation with history saved to `.ollama-sessions/` |
| `persona <role> <prompt>` | Apply a pre-made system prompt (engineer, writer, tutor, critic, socratic) |
| `creative <prompt>` | Temperature 1.0 — brainstorming, stories, idea generation |
| `precise <prompt>` | Temperature 0.1 — facts, definitions, deterministic output |
| `pipe <instruction>` | Read stdin, apply an instruction, print output |

## How to dispatch

1. Identify which mode fits the user's request:
   - "ask my local model X" → `ask`
   - "have a conversation", "chat with", "talk back and forth" → `session`
   - "be like a senior engineer and..." → `persona engineer`
   - "brainstorm", "creative", "imaginative" → `creative`
   - "define", "exactly", "precisely", "what is" → `precise`
   - Any command with a pipe (`| ./ai local-ai pipe`) → `pipe`
2. Run via: `bash .claude/skills/local-ai/scripts/<action>.sh <args>`
   Or equivalently: `./ai local-ai <action> <args>`
3. Return the model's output directly.

## Persona library

Available personas (in `prompts/personas/`):

| Persona | Voice |
|---|---|
| `engineer` | Senior software engineer — terse, technical, no fluff |
| `writer` | Thoughtful essayist — clear, humane |
| `tutor` | Patient teacher — analogies, checks for understanding |
| `critic` | Skeptical editor — pushes back, finds weaknesses |
| `socratic` | Asks questions instead of answering |

To add a persona: drop a new `.md` file in `prompts/personas/`. The filename (minus `.md`) becomes the persona name.

## Examples

```bash
./ai local-ai ask "Explain entanglement in one sentence."
./ai local-ai persona critic "Here's my business plan: ..."
./ai local-ai creative "Give me five absurd product ideas."
./ai local-ai precise "What's the boiling point of water at 1500m altitude?"
cat long.txt | ./ai local-ai pipe "Summarize this as three bullet points."
./ai local-ai session work       # resumes conversation named "work"
```
