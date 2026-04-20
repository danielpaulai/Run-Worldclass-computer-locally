# Skills Bundled With This Repo

This repo ships **15 layered skills** that turn your local AI into a real working system. Each skill is a folder under `.claude/skills/` with:

- A `SKILL.md` telling Claude Code *when* to use it
- A `scripts/` directory of 3–7 focused actions
- Optional `prompts/`, `data/`, or `lib/` for supporting files

You can invoke them two ways:

1. **Through Claude Code** — just talk naturally. The SKILL.md descriptions tell Claude Code when each one fits.
2. **From the terminal** — use the bundled `./ai` dispatcher:
   ```bash
   ./ai                       # list all skills
   ./ai local-ai              # list a skill's actions
   ./ai local-ai ask "hello"  # run an action
   ```

## The 15 skills

### Core conversation

| Skill | Actions | What it does |
|---|---|---|
| `local-ai` | ask, session, persona, creative, precise, pipe | The core conversation engine. Five personas included (engineer, writer, tutor, critic, socratic). |

### Understanding content

| Skill | Actions | What it does |
|---|---|---|
| `summarize` | tldr, bullets, outline, actions, chunk, any | Five summary styles. `chunk` does map-reduce for long files. `any` auto-detects PDF, DOCX, MD, TXT. |
| `local-rag` | ingest, query, sources, rebuild, stats | Index any folder, ask questions over it, get cited answers. Uses `nomic-embed-text` for embeddings — all local. |
| `local-research` | plan, gather, synthesize, full | Multi-step research orchestrator. `full` runs the whole pipeline. |

### Making things

| Skill | Actions | What it does |
|---|---|---|
| `local-code` | explain, review, refactor, test-gen, doc, debug | Private coding assistant for proprietary code. |
| `local-writer` | draft, outline, edit, rewrite, expand | Long-form writing. Rewrite in formal / casual / tight / warm / punchy / academic voices. |
| `local-agent` | plan, run, verify, checkpoint | Autonomous task runner with safety rails. Confirms every shell step. |
| `local-workflow` | save, run, list | Chain multiple skill calls into named reusable workflows (YAML). |

### Learning

| Skill | Actions | What it does |
|---|---|---|
| `local-tutor` | explain, quiz, feynman, socratic | Four teaching modes for different learning stages. |
| `local-journal` | write, reflect, weekly-review | Private daily journal with AI reflection. Entries never leave disk. |

### Ops & trust

| Skill | Actions | What it does |
|---|---|---|
| `model-manager` | list, recommend, install, remove, switch, disk-audit | Full lifecycle control with a curated catalog. |
| `benchmark` | quick, full, compare-models, memory, report | Measure tokens/sec, TTFT, RAM. Ranks all installed models. |
| `compare` | single, local-vs-local, rubric | Side-by-side evaluation. Self-scoring rubric mode. |
| `privacy-audit` | listeners, network-watch, check, report | Prove nothing's leaving your machine. Generates shareable privacy report. |
| `model-doctor` | health, restart, clear-cache, repair, logs | Self-diagnose and heal. Cross-platform service restart. |

## Quick session for teachers

A ~40-minute class using these skills:

| Time | Skill / action | What students do |
|---|---|---|
| 0–12  | (setup) | `./preflight.sh && ./setup.sh` |
| 12–14 | `./ai local-ai ask` | First conversation |
| 14–18 | `./ai local-ai persona critic` | Try the 5 personas on the same question |
| 18–22 | `./ai summarize any` | Summarize a "confidential" sample doc |
| 22–26 | `./ai local-rag ingest` + `query` | Index a folder and ask questions |
| 26–30 | `./ai benchmark full` | Measure their laptop's throughput |
| 30–34 | `./ai compare single` | Local vs cloud side-by-side |
| 34–38 | `./ai privacy-audit check` | Verify nothing is leaking |
| 38–45 | `./ai local-agent plan` | Watch the agent propose a task and execute it step-by-step |

## Architecture

```
.claude/
  skills/
    lib/
      common.sh                 # shared helpers: get_model, ensure_ollama, ai_ask, ai_ask_system, ai_embed
    <skill>/
      SKILL.md                  # frontmatter + when-to-use + dispatch
      scripts/
        <action>.sh             # one focused capability per file
      prompts/                  # (optional) reusable prompt templates
      data/                     # (optional) reference data
ai                               # top-level dispatcher
```

Every script sources `lib/common.sh`, which handles: finding the repo root, reading the active model, auto-starting Ollama if it's down, and making `/api/chat` calls with JSON-safe escaping. Skills never duplicate this.

## Writing your own skill

```bash
mkdir -p .claude/skills/my-skill/scripts
cat > .claude/skills/my-skill/SKILL.md <<'MD'
---
name: my-skill
description: One-sentence description with trigger phrases the matcher will pick up on.
---
# My Skill
Instructions for Claude Code.
MD
cat > .claude/skills/my-skill/scripts/hello.sh <<'SH'
#!/usr/bin/env bash
# Say hello using the active local model.
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../../lib/common.sh"
ensure_ollama
ai_ask "$(get_model)" "Say hello in five words."
SH
chmod +x .claude/skills/my-skill/scripts/hello.sh
./ai my-skill hello
```

That's it. Claude Code picks it up automatically on its next run in this repo.

## Technical notes

- All scripts shell out to `ollama run` or `curl` the Ollama API — no proxying Claude Code through Ollama via `ANTHROPIC_BASE_URL`. That path needs a protocol translator and adds failure modes.
- RAG, agent, and research skills use Python 3 (stdlib only) for JSON/embedding/file handling. Homebrew's Ollama install pulls Python 3.14 as a dep, so you already have it.
- Workflows require PyYAML: `pip3 install pyyaml` (or the install step of `local-workflow save` will remind you).
- The RAG skill needs `nomic-embed-text` — it's pulled automatically on first `ingest` (~150 MB).
