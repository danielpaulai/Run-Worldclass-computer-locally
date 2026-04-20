# Use Cases — Who This Is Actually For

A private AI that lives on your laptop is worth something only if you know what to do with it. Here are five real people, their real Monday, and the exact commands they'd run.

---

## The one-line positioning

Before this tool, a small business owner had two choices for getting AI help:

1. **Use ChatGPT** — fast, but send client data to the cloud, pay monthly, be offline-fragile.
2. **Do it by hand** — slow, but private.

This is a third choice: **fast AND private AND free.** That's the whole promise.

---

## Who needs this

A cloud AI is fine for anything public. But every small business owner has a **category of work they shouldn't paste into a cloud AI** — and today they either do it manually or paste it anyway and hope no one notices.

That category is exactly what this tool handles.

---

## Five people, five Mondays

### 1. Priya — freelance strategy consultant

Every client makes her sign an NDA. She literally is not allowed to upload their decks to ChatGPT.

- **9:12 am.** An Acme Corp strategy deck lands — 34 pages, PDF. She runs:
  ```
  ./ai summarize any ~/Downloads/acme-strategy.pdf
  ```
  Gets a TLDR, 8 bullet takeaways, and a list of action items. The PDF never left her laptop.

- **11:30 am.** A client writes a 900-word email pushing back on her recommendation. She runs:
  ```
  ./ai local-ai persona engineer "Draft a response that holds the line on the recommendation, acknowledges their concern, and offers one concrete compromise."
  ```
  Gets a tight three-paragraph reply. She edits for tone and sends.

- **Friday afternoon.** Every email and doc from Acme over the past year has been sitting in `~/clients/acme/`. She runs:
  ```
  ./ai local-rag ingest ~/clients/acme
  ./ai local-rag query "What did Acme say about their Q3 pricing concerns?"
  ```
  Gets a cited answer across 14 months of correspondence. Would have taken her 45 minutes to dig up manually.

---

### 2. Gus — second-generation small-practice accountant

Client books are regulated. Pasting a P&L into ChatGPT would be a breach of his professional ethics.

- **Monday morning.** A client dumps a 400-row expense CSV on him.
  ```
  ./ai summarize bullets ~/clients/hartwell/2025-q1-expenses.csv
  ```
  Gets the categories that moved the most, the three line items that look wrong, and a suggested follow-up question for the client.

- **Tuesday.** He's been handling weird tax questions for 22 years. All his notes sit in one folder.
  ```
  ./ai local-rag ingest ~/tax-memory
  ./ai local-rag query "Have I ever handled crypto staking income? What did I conclude?"
  ```
  He gets back his own 2022 memo, cited by filename. His past self becomes a colleague he can query.

- **Friday.** Monthly client newsletter draft.
  ```
  ./ai local-writer draft "Intro paragraph explaining the new IRS rule on backdoor Roth conversions. Audience: retail investors. Tone: plain, no jargon."
  ./ai local-writer edit newsletter-draft.md
  ```

---

### 3. Siobhan — executive coach

Her session notes are the most sensitive documents in her practice. They contain what executives tell her about their boards, their co-founders, their marriages. Cloud AI is not on the table.

- **After each 1:1.** Her notes are 2–3 pages of scribbled markdown.
  ```
  ./ai summarize actions ~/coaching/notes/2026-04-20-mark.md
  ```
  Gets the commitments Mark made, the questions he deferred, and the pattern she might want to surface next time.

- **Wednesday evening.** She wants to spot patterns across her own practice without re-reading every file.
  ```
  ./ai local-rag query "How often have my clients mentioned burnout in the last 3 months? What were the common precipitating factors?"
  ```

- **Weekly on Friday.**
  ```
  ./ai local-journal weekly-review
  ```
  Her own private journal, reflected back to her by the model. No one sees it but her.

---

### 4. Tomás — solo SaaS founder, pre-seed

Ship-at-2am energy. His codebase is his IP. Customer feedback contains other people's confidential feedback.

- **Daily LinkedIn.**
  ```
  ./ai local-ai persona writer "Draft a 150-word post about how we cut onboarding time from 14 days to 3 by removing a config step. Land it on the counter-intuitive thing: we added work to ourselves, not to the user."
  ```

- **Payment code is the most sensitive file in his repo.** He won't paste it into any cloud service.
  ```
  ./ai local-code review src/payments/stripe-webhook.ts
  ./ai local-code test-gen src/payments/stripe-webhook.ts
  ```

- **Competitive research, done in one shot.**
  ```
  ./ai local-research full "How is Plaid's pricing model for ACH different from Modern Treasury's? What are the trade-offs for a company at $50k MRR?"
  ```
  Gets a 6-page report, organized into plan → findings → synthesis.

---

### 5. Ottilie — solo attorney

Everything crosses her desk is privileged. She uses AI anyway because her competition does, but she'd lose her license if she uploaded the wrong file.

- **Contract review, 40 pages.**
  ```
  ./ai summarize any ~/matters/deloney/nda-draft-v4.pdf
  ./ai local-code review ~/matters/deloney/nda-draft-v4.pdf
  ```
  (Yes, `local-code review` works on legal text — the prompt asks for issues, edge cases, and risks. It finds them in prose too.)

- **Prior cases as a queryable memory.**
  ```
  ./ai local-rag query "What was my argument on fiduciary duty in the Henderson matter? What precedents did I cite?"
  ```

- **Draft a settlement offer.**
  ```
  ./ai local-writer draft "Settlement offer for plaintiff in Henderson. Range: $50K. Emphasize mutual release and a confidentiality clause consistent with California standard. Tone: firm but not adversarial."
  ./ai local-writer rewrite draft.md formal
  ```

---

## A common pattern across all five

Every one of them does three things on repeat:

1. **Intake** — a file arrives (PDF, email, spreadsheet, notes). They use `summarize` to extract what matters.
2. **Respond** — they need to write back. They use `local-writer` or `local-ai persona` to draft.
3. **Recall** — they need to find something they already know. They use `local-rag` to search their own past work.

If you build nothing else into your practice, those three cover 80% of daily use.

---

## Matching skills to roles

| If you're a... | Start with these three skills |
|---|---|
| Consultant / strategy | `summarize` · `local-writer` · `local-rag` |
| Accountant / bookkeeper | `summarize bullets` · `local-rag` · `local-writer draft` |
| Coach / therapist | `local-journal` · `summarize actions` · `local-rag` |
| Solo founder | `local-code` · `local-ai persona writer` · `local-research` |
| Lawyer | `summarize any` · `local-code review` · `local-rag` |
| Teacher / course creator | `local-tutor quiz` · `local-writer expand` · `summarize bullets` |
| Real estate agent | `summarize` · `local-writer rewrite warm` · `local-rag` |
| Doctor / clinician (notes only, not PHI) | `summarize actions` · `local-rag` · `local-journal` |

---

## When a cloud AI is still better

Be honest with yourself. This tool is not magic. Reach for ChatGPT or Claude when:

- The task doesn't involve private data.
- You need the absolute strongest reasoning (hard math, long-context legal analysis, frontier coding).
- You need to browse the web.
- You need image generation or advanced vision.

For everything else — summaries, drafts, recall, reviews, tutoring, journaling — your laptop is enough.

---

## Prove it yourself

If you're not convinced this is actually private, run:

```
./ai privacy-audit check
```

Then turn off your wifi. Run `./chat.sh`. The model still works. Nothing needed the network.

That's when it clicks.
