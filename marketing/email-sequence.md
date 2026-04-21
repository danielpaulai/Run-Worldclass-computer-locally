# 5-Email Launch Sequence

For your list of workshop attendees + warm network. Schedule these over the week of launch.

---

## Email 1 — Pre-launch (send 24–48 hrs before workshop)

**Subject:** A private AI that runs on your laptop (tomorrow's workshop)

Hey,

Tomorrow's workshop has a name now: **Purely Personal.**

It's a private AI that runs entirely on your laptop. No cloud, no subscription, no data ever leaving your machine.

Why I built it: every small business owner I know has a folder of docs they'll never paste into ChatGPT — client contracts, financial records, session notes, anything under NDA. They end up using AI for the easy 30% of their work and doing the hard 70% manually.

Purely Personal is for the hard 70%.

Tonight, install it:
→ github.com/danielpaulai/Run-Worldclass-computer-locally

Takes about 15 minutes. If it fails, come to the session anyway — we've got a fallback.

See you tomorrow.
— Daniel

---

## Email 2 — Launch day (send 2 hrs before workshop)

**Subject:** Doors open in 2 hours

Hey,

Quick checklist for today's session:

□ Laptop, charged
□ The app installed (the DMG or EXE I sent yesterday)
□ One document you want summarized (nothing confidential — we're practicing)
□ One task you currently do manually that AI might help with

If you didn't install successfully, you'll still be fully in the session. We'll get it working in the first 5 minutes.

See you at [time].

— Daniel

---

## Email 3 — Day 1 recap (send the evening of workshop)

**Subject:** Your first 5 tasks with Purely Personal

Hey,

Thanks for coming today. Quick recap of the commitment:

You now have a private AI on your laptop. Free, offline, yours.

Here's how to make it a habit this week. One task per day, 10 minutes each:

**Monday** — Summarize a real document. A contract. A long email thread. A PDF you've been putting off.

**Tuesday** — Draft something you'd normally dread writing. A cold email. A tricky Slack message. A policy memo.

**Wednesday** — Drop a folder of your own notes into the app. Ask it a question about something you used to know but forgot.

**Thursday** — Run a document through it you'd never paste into ChatGPT. Feel the difference.

**Friday** — Ask it to teach you something. Socratic mode — it asks YOU questions instead of lecturing.

By Friday you'll know whether this lives in your workflow permanently.

Questions, hit reply.

— Daniel

P.S. If you build something cool on top of it, share. The repo is open.

---

## Email 4 — Day 3 (send Wednesday-ish)

**Subject:** The one feature that changed my mind

Hey,

Two days in. Quick note on the feature that flipped this from "interesting" to "essential" for me:

Drag a folder of your own notes into the app.

Index takes about a minute. Then ask it questions. It answers from YOUR archive — things you wrote, decided, concluded months or years ago.

I ran it on three years of consulting memos and asked: "Have I ever argued that a company should hire a COO before $5M ARR?" It gave me back my own 2023 memo, cited by filename, with the conclusion quoted.

Your past self becomes a colleague you can query.

(Command: `./ai local-rag ingest ~/path/to/folder` — then query with `./ai local-rag query "question"`)

If you try this and it blows your mind, reply. I want to know.

— Daniel

---

## Email 5 — Day 7 (send the Monday after)

**Subject:** How'd your week go?

Hey,

One week since you installed Purely Personal. Quick question:

**Did it stick?**

Two honest options:

1. **Yes** — it's in my workflow now. I'm using it for [X]. Reply and tell me what X is, I'm collecting stories.

2. **No** — I installed it but didn't end up using it. Reply and tell me what got in the way. Tool issue? UX? Didn't have the right use case? I want to know.

Either answer is useful. The tool gets better from real feedback.

If you want to keep going, here's what's coming in v0.2 (~2 weeks out):

- Conversation history sidebar
- Built-in file summarization (drop a file, pick a style, no terminal)
- Model switcher (try different brains side-by-side)
- Proper app icon + code signing (no more "unverified developer" warning)

I'll send the next build when it ships.

— Daniel

---

## Guidelines for using these

- **Don't send all 5 no matter what.** If someone replies to email 3 saying "this isn't for me," remove them from the sequence.
- **Personalize line 1 of each** with something specific to your relationship if possible.
- **Reply to everyone** — even a one-line "glad it's working" builds trust.
- **Track opens/replies.** Email 3 and 4 are the test. If open rates are >40% and replies >5%, you have a real product.
