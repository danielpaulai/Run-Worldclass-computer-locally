---
name: local-research
description: Multi-step research orchestration using the local model. Four actions — plan (break a question into sub-questions), gather (answer each sub-question using the model's knowledge), synthesize (combine findings into a report), full (end-to-end: plan + gather + synthesize). Best combined with local-rag for grounded research over the user's docs. Use when the user says "research X", "investigate", "prepare a brief on", "deep dive".
---

# Local Research — multi-step orchestrator

| Action | Does |
|---|---|
| `plan <question>` | Produces 5-8 sub-questions covering the topic |
| `gather <plan-file>` | Runs each sub-question through the model, collects answers |
| `synthesize <gather-file>` | Combines answers into a coherent report with sections and citations |
| `full <question>` | Orchestrates plan → gather → synthesize end-to-end |

Outputs are saved to `.research/<slug>-<timestamp>/`.

## Examples

```bash
./ai local-research full "What makes a great onboarding experience for SaaS?"
./ai local-research plan "Compare three schools of American pragmatism"
./ai local-research gather .research/xyz/plan.md
./ai local-research synthesize .research/xyz/gathered.md
```

## Pair with local-rag

For grounded research over *your* documents, ingest first then use rag queries as your gather step:

```bash
./ai local-rag ingest ~/research-notes
./ai local-research plan "How have customer priorities shifted in 2025?"
# Then manually run ./ai local-rag query for each sub-question from the plan
```
