# Real Output Gallery

Every file in this folder is a **real run** of a skill on `qwen2.5:7b` (5 GB local model). No fakes, no edits — the output is what the model actually produced.

Use this folder two ways:

1. **Pre-class preview** — students who can't (or haven't yet) installed the tool can read these and see exactly what they'd get.
2. **In-class reference** — if a student's install isn't working during the session, they can follow along visually and still learn the ideas.

## What's in here

| File | Skill | Verdict |
|---|---|---|
| [`01-summarize-tldr.md`](./01-summarize-tldr.md) | `summarize tldr` on README | **Strong** — 3 accurate sentences |
| [`02-local-code-review.md`](./02-local-code-review.md) | `local-code review` on chat.sh | **Strong** — found real issues, rewrote the script |
| [`03-local-writer-post.md`](./03-local-writer-post.md) | `local-writer draft` LinkedIn post | **Mixed** — flipped the logic of the prompt |
| [`04-local-tutor-feynman.md`](./04-local-tutor-feynman.md) | `local-tutor feynman "transformer"` | **OK** — friendly but fuzzy analogy |
| [`05-local-writer-cold-email.md`](./05-local-writer-cold-email.md) | `local-writer draft` cold email | **Weak** — ignored the instruction |
| [`06-local-ai-hallucination.md`](./06-local-ai-hallucination.md) | `local-ai ask` "What is Ollama?" | **Wrong but confident** — THE demo moment |
| [`07-workflow-daily-brief.md`](./07-workflow-daily-brief.md) | `local-workflow run daily-brief` end-to-end | **Useful** — journal → reflection → today's priorities |
| [`08-workflow-code-ship-check.md`](./08-workflow-code-ship-check.md) | `local-workflow run code-ship-check` end-to-end | **Strong** — review + tests + docs + verdict in one command |

## Pattern students should walk away with

The local 7B model is:

| Good at | Weak at |
|---|---|
| Summarizing text you give it | Facts it has to recall from training |
| Reviewing code you paste in | Writing with real voice from a short prompt |
| Paraphrasing & extracting | Following nuanced instructions |
| Fast first drafts | Final-quality output |

**Rule of thumb:** use it when you can *verify* its answer. Don't trust it blindly.

**Cloud AI** (Claude, ChatGPT) is still sharper on reasoning, voice, and instruction-following. But for everything in the "good at" column, local is now genuinely competitive — and it's free, private, and offline.
