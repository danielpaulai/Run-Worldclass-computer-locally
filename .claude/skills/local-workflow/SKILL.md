---
name: local-workflow
description: Save, run, and share multi-step prompt chains. Turn any sequence of actions (summarize -> review -> draft reply) into a reusable named workflow. Three actions — save (record a chain), run (execute a saved chain), list (show saved workflows). Use when the user says "save this workflow", "run my workflow", "automate this sequence", "make this repeatable".
---

# Local Workflow — reusable prompt chains

Chain together any sequence of `./ai` calls into a named workflow, then run it with one command.

| Action | Does |
|---|---|
| `save <name> <file>` | Save a workflow definition |
| `run <name> [args]` | Run a saved workflow |
| `list` | Show all saved workflows |

Workflows live in `.workflows/<name>.yaml`.

## Workflow format

```yaml
# .workflows/daily-brief.yaml
name: daily-brief
description: Summarize yesterday's journal + plan today
steps:
  - name: summarize-journal
    run: ./ai local-journal weekly-review
  - name: plan-day
    run: ./ai local-ai persona tutor "Given the above review, what are 3 priorities for today?"
    input: ${previous}
```

## Examples

```bash
./ai local-workflow save daily-brief .workflows/daily-brief.yaml
./ai local-workflow run daily-brief
./ai local-workflow list
```
