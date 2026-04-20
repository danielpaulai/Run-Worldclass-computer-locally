---
name: local-journal
description: Private daily journaling with AI reflection. Three actions — write (add a new entry with optional AI prompt), reflect (model reads entries and offers observations), weekly-review (summarize the past 7 days). All entries stored locally in .journal/. Use when the user says "journal", "daily reflection", "weekly review", "help me process my day".
---

# Local Journal — private daily reflection

| Action | Does |
|---|---|
| `write [prompt]` | Opens an editor for today's entry; optional AI prompt |
| `reflect` | Model reads recent entries and offers thoughtful observations |
| `weekly-review` | Summarizes the past 7 days with themes and patterns |

Entries live in `.journal/YYYY-MM-DD.md`. Never uploaded anywhere.

## Examples

```bash
./ai local-journal write
./ai local-journal write "What's the one thing you kept avoiding today?"
./ai local-journal reflect
./ai local-journal weekly-review
```
