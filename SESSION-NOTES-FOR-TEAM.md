# Session Notes for the Team

**Session:** Run a World-Class AI on Your Laptop
**Length:** 60 minutes
**Instructor:** Daniel Paul
**Audience:** Knowledge workers (consultants, founders, coaches, lawyers, accountants, writers)

---

## Before we start

- 15-minute pre-class install (done by students tonight, link sent separately)
- Students arrive with Ollama running + `qwen2.5:7b` pulled + Purely Personal app installed
- No setup time burned in class
- Backup plan: 10% of students will arrive broken, we fix them in the first 5 min

---

## The arc of the hour

- **0:00–0:05** — Opening moment (the "holy shit, it's local" demo)
- **0:05–0:15** — What this is, why it matters, what's in it for them
- **0:15–0:40** — Hands-on with the 8 core workflows
- **0:40–0:50** — Privacy proof + "when to use this vs ChatGPT"
- **0:50–0:60** — Q&A, close, what to do this week

---

## Opening moment (5 min)

- Open with a question: *"Who here has ever hesitated before pasting a document into ChatGPT because it had confidential info?"*
- Wait for hands to go up (they will)
- Paste a fake-but-realistic contract into Purely Personal live
- Let it stream the summary on screen, WiFi off (show the OS network indicator)
- Pivot line: *"And that just happened on my laptop. Nothing uploaded. Now imagine you're the one with the contract."*

---

## The what + why (10 min)

- **What it is:** a real AI that runs on your laptop, no cloud, no account, no subscription
- **Why it matters:** most people stopped using AI for the confidential half of their work. This gets it back.
- **What's in it for them:**
  - Work on contracts, session notes, legal docs, tax stuff
  - Draft emails they don't want recorded on OpenAI's servers
  - Review their own code without uploading IP
  - Search a whole folder by asking questions
  - Free forever
  - Works offline (plane, coffee shop, SCIF)
- Key frame: this isn't "replace ChatGPT." It's "add the missing half."

---

## Hands-on (25 min)

Walk them through the 8 one-click buttons. Each one is ~3 min.

- **Summarize** — paste a long doc, hit the button, get a summary
- **Reply** — paste a hard email, get a draft reply
- **Clearer** — paste their own bad writing, get a cleaner version
- **Explain** — paste a concept or code, get a plain-English explanation
- **Decide** — paste options, get a structured comparison
- **Brainstorm** — give a topic, get 10 ideas
- **Index a folder** — pick a folder of notes, ask "what did I decide about X?"
- **Save chat** — save any conversation as a clean markdown file

Have them do each one on their own material. Rotate around the room (or watch chat if virtual).

---

## Privacy proof (10 min)

- Turn off WiFi live. Run the model. It still works.
- Show the Activity Monitor / Resource Monitor: no network traffic from the app
- Contrast with ChatGPT: same moment, WiFi off, it dies
- Key line: *"This is what 'local' actually means."*

---

## When to use what (5 min)

- Use Purely Personal for:
  - Confidential documents
  - Offline work
  - Routine tasks (summarize, simplify, second-draft)
  - Learning + practicing
- Use ChatGPT / Claude for:
  - Hard reasoning
  - Latest news (model is trained to a cutoff date)
  - Very long documents (200+ pages)
  - Tasks that need absolute best-in-class quality
- The session teaches the line between the two

---

## Close + Q&A (5 min)

- Recap what they just did
- Give them the 5-day follow-through (Post-Class activity)
- "Bring me back one story next week where this saved you a cloud upload"
- Share the repo link, the class email for questions, and thank them

---

## Things to have open

- Purely Personal desktop app (Mac or Windows)
- Terminal with Ollama running
- A sample contract / email / code file for the live demos
- The class Notion page with the 8 workflows bookmarked
- The landing page as a visual reference

---

## Things to say (pin these)

- *"This isn't magic, it's a 4.7 GB file on your disk."*
- *"Every prompt you've hesitated to paste, this is for that."*
- *"It's free because it's open source, not because we'll charge later."*
- *"You won't replace ChatGPT. You'll add the missing half."*
- *"If you can read, you can run this AI."*

---

## Things not to say

- No "leverage", "unlock", "synergy", or "revolutionary"
- No em dashes in live chat replies (they're the tell that someone else typed it)
- No overclaiming: be honest about the 7B ceiling, when it's not enough, what it's weaker at
- No jargon about embeddings, cosine similarity, RAG without explaining

---

## Risks to plan for

- **10% of installs break** — have a quick fix list ready (Ollama not running, model not pulled, SmartScreen block, Gatekeeper block)
- **5% of laptops are too slow** — have the 3b model ready as a fallback
- **Corporate laptops with admin blocks** — pre-warned in the email, backup is WSL2 or class observer mode
- **Someone asks about fine-tuning or training** — say "on the v0.3 roadmap, not tonight"
- **Someone asks about images / vision / video** — say "Ollama supports vision models, not in the app yet, show them `ollama pull llava` afterwards"

---

## Follow-up after class

- Send the Post-Class 5-day plan (separate Notion page)
- Collect 3 real use cases from attendees for the next cohort
- Ask for GitHub stars 😉
- One-week check-in email: "what did you use it for?"
