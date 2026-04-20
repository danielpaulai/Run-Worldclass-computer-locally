# Post-Class Activity — Make It Stick This Week

**Goal:** by the end of the week, you've used your local AI on five real tasks from your actual work. That's the threshold where the habit forms.

---

## The 5-task week

Pick one per day. Each takes 5–10 minutes.

### Day 1 — Summarize a real document

A report, a contract, a long email thread, a PDF you've been putting off reading.

```bash
./ai summarize any <path/to/file>
./ai summarize bullets <path/to/file>
./ai summarize actions <path/to/file>
```

Try all three on the same doc. Compare. One of them will click for how your brain reads.

### Day 2 — Draft something you'd normally dread writing

A cold email, a performance review comment, a tricky Slack message, a policy memo.

```bash
./ai local-writer draft "I need to write [what]. Context: [what the reader needs to know]. Tone: [warm / formal / tight]. Max 150 words."
./ai local-writer rewrite <draft.md> warm
```

**Crucial tip:** if the first draft is mid, paste one of your own past writings in as an example of your voice. Then ask again. Night and day.

### Day 3 — Index something you know well and ask it questions

Your notes folder. Your past emails. Your journal. Your project docs.

```bash
./ai local-rag ingest ~/path/to/folder
./ai local-rag query "what did I conclude about <topic> last year?"
```

This is the skill that turns your own past work into a queryable memory. The moment it gives you back something you forgot you knew — you'll get it.

### Day 4 — Review something before you ship it

Code, a proposal, a contract, a slide deck outline. Anything where a second set of eyes would help.

```bash
./ai local-code review <path/to/file>
```

Despite the name, this works on non-code too — the prompt asks for issues, edge cases, and risks, which applies to any written argument.

### Day 5 — Ask it to teach you something

Something you're curious about but haven't made time to learn.

```bash
./ai local-tutor feynman "what is vector search"
./ai local-tutor quiz "basics of recursion" 5
./ai local-tutor socratic "the efficient market hypothesis"
```

The Socratic mode is especially good — it asks you questions instead of lecturing. You learn faster.

---

## Three experiments worth running once

### 1. The privacy audit

```bash
./ai privacy-audit check
```

Turn off your wifi. Run a chat. Watch it still work. That's when "private AI" stops being a slogan and starts being real.

### 2. The benchmark

```bash
./ai benchmark full
./ai benchmark html-report
open .benchmarks/*/report.html
```

Now you have a screenshot-able answer to "how fast is it?" Share it with a peer who has different hardware — you'll have a real debate about which chips are worth the money.

### 3. The model swap

```bash
./ai model-manager recommend coding
./ai model-manager install qwen2.5-coder:7b
./ai model-manager switch qwen2.5-coder:7b
./ai local-code review <same file as before>
```

Compare the output. A coder-tuned model is measurably better at code review than a general model of the same size. This teaches you that "which model" is a real lever, not a black box.

---

## If you want to go deeper

In roughly this order:

1. **Write your own skill.** Template is in [SKILLS.md](./SKILLS.md). A 20-line SKILL.md with a 10-line script gives you a reusable command for your own workflow.
2. **Build a workflow.** Chain skills together with a YAML file in `.workflows/` — see the three examples in the repo (`daily-brief`, `research-brief`, `code-ship-check`).
3. **Try a larger model.** If you have 32+ GB of RAM, `qwen2.5:14b` is noticeably smarter. If you have 64+ GB, `gpt-oss:20b` is the closest open-weight model to cloud frontier.
4. **Set up Open WebUI.** A ChatGPT-style browser UI for your local model, takes one Docker command. Easier for non-technical family members or teammates.
5. **Share back.** If you build a skill or a workflow others would use, open a PR on this repo.

---

## If it stops working

Most common issues:

| Symptom | Fix |
|---|---|
| `./chat.sh` hangs | `./ai model-doctor health` — runs a diagnostic |
| First response is slow | Normal — model is loading into RAM. Subsequent responses fast. |
| Out of disk space | `./ai model-manager disk-audit`, then `./ai model-manager remove <largest>` |
| Model gives weird answers | Try `./ai local-ai precise` (low temperature) or swap to a bigger model |
| Ollama seems frozen | `./ai model-doctor restart` |

---

## The habit, stated plainly

The reason this tool is worth installing is that **any time you're about to copy-paste something you shouldn't share into ChatGPT, you have a second option now.**

A confidential doc. A real client name. A proprietary code file. Personal journal content. Any of it.

That's the switch you're trying to flip. Every time you reach for local instead of cloud when the data is private — you win the trade.

See you next session.
