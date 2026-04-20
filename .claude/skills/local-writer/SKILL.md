---
name: local-writer
description: Long-form writing assistant using the local model. Five actions — draft (first draft from a brief), outline (structured outline), edit (tighten existing prose), rewrite (rewrite in a different voice/register), expand (turn an outline into prose). Great for emails, essays, proposals, blog posts, internal memos. Use when the user asks to "draft", "outline", "edit", "tighten", "rewrite", or "expand" any piece of writing.
---

# Local Writer — long-form writing assistant

| Action | Does |
|---|---|
| `draft <brief>` | First draft from a short brief |
| `outline <topic>` | Structured outline with sections |
| `edit <file>` | Tighten existing prose — cut filler, improve flow |
| `rewrite <file> <voice>` | Rewrite in a different voice (formal/casual/tight/warm) |
| `expand <outline-file>` | Turn an outline into full prose |

## Examples

```bash
./ai local-writer draft "Email to team explaining we're pausing the launch"
./ai local-writer outline "Why remote-first teams ship faster"
./ai local-writer edit ./draft.md
./ai local-writer rewrite ./draft.md formal
./ai local-writer expand ./outline.md
```
