# 5-Email Launch Sequence, Purely Personal

Five emails. One per week-critical moment. Punchy voice, one idea per line, always one CTA.

---

## Email 1, Pre-launch (send 24,48 hrs before)

**Subject:** About the tool you use for half your work

Hey,

Quick one before tomorrow.

You have a folder.

Contracts. Session notes. Internal docs. Things you signed NDAs about.

You've never pasted those into ChatGPT.

So you do them by hand. 45 minutes each time.

Tomorrow's session is about the 45 minutes.

The app we'll install together runs a world-class AI on your laptop. No cloud. No login. $0.

Your documents never leave your machine.

**Tonight, do this:**

[Clone the repo · 15 minutes · link]

Walk away during the 12-minute download. You don't need to sit there.

If it fails, come anyway. I've built a fallback so nobody gets left behind.

See you tomorrow., Daniel

---

## Email 2, Launch-day morning (send 2 hours before session)

**Subject:** Doors open in 2 hours

Quick list:

- Laptop, charged.
- The app installed (DMG link in last email).
- **One document you'd like summarized.** Non-confidential, 2,10 pages.
- **One thing you do manually** that AI might help with.

If your install didn't finish, still come. You'll be in the session fully. We'll fix yours in the first 5 minutes.

One link, one time: [GitHub]

See you at [time]., Daniel

---

## Email 3, Day-1 recap (evening of workshop)

**Subject:** Your 5-day plan

Hey,

Thanks for showing up.

You have a private AI on your laptop now. That's the expensive part. The rest is habit.

**Here's the 5-day plan. 10 minutes each. Make it real.**

**Monday.** Summarize a real document. A long email thread. A PDF you've been putting off.

**Tuesday.** Draft something you dread writing. A tough email. A tricky Slack. A policy memo.

**Wednesday.** Drop a folder of your own notes in. Ask it a question about something you used to know but forgot.

**Thursday.** Run a document through it that you'd never have put in ChatGPT. Feel the difference.

**Friday.** Ask it to teach you something. Use Socratic mode, it asks YOU questions.

By Friday, you'll know.

If it's in your workflow, keep going.

If it's not, tell me why. I'll fix it., Daniel

P.S. The repo is open. If you make something cool on top, ship it.

---

## Email 4, Day-3 "the one trick" (Wednesday)

**Subject:** The feature I didn't explain properly

Hey,

Midweek note.

There's one feature I rushed in the session that I want you to try:

**Drop a folder of your own notes into the app.**

Index takes 60 seconds.

Then ask it questions.

It answers from YOUR archive. Things you wrote, decided, concluded months or years ago.

I ran it on three years of my own consulting memos and asked:

*"Have I ever argued that a company should hire a COO before $5M ARR?"*

It handed me back my own 2023 memo, cited by filename, conclusion quoted.

**Your past self becomes a colleague you can query.**

Command:

```
./ai local-rag ingest ~/path/to/your/notes
./ai local-rag query "your question here"
```

(In v0.2 this is a button inside the app. v0.2 ships next week.)

Try it. Reply and tell me what it found that you'd forgotten., Daniel

---

## Email 5, Day-7 check (Monday after)

**Subject:** Did it stick?

One week since you installed.

One honest question:

**Did it stick?**

Two answers are useful. Either one:

1. **Yes.** It's in my workflow. I'm using it for [X]. Reply with what X is. I collect stories.

2. **No.** I installed it but haven't opened it since Thursday. Reply with why. Was it the UX? A missing feature? Wrong use case? I fix the real answers.

Either way, here's what's shipping in v0.2 (next week):

- A conversation history sidebar (past chats you can return to)
- A built-in RAG panel (drop-folder, ask-a-question, no terminal)
- Saved prompts library (your own quick-actions)
- A real app icon
- Auto-updates

Reply with your verdict. I'm reading every one., Daniel

---

## Rules for sending

- **Don't send all 5 blindly.** If someone replies to Email 3 saying "not for me," drop them.
- **Personalize line 1** of each one with something real from the person's business. (*"Thinking of the contract work you mentioned last week…"*)
- **Reply to every reply.** Even "glad it's working" builds trust and gets you more stories.
- **Watch Email 3.** Reply rate on Email 3 is your real signal. Above 10% = keep building. Below 3% = you have a positioning problem, not a feature problem.

---

## Writing style used here

- Sentences under 15 words wherever possible.
- One idea per line.
- Specific nouns, specific numbers.
- No "unleash," "empower," or "transform."
- Every email has exactly one CTA. No A/B options.
- Name the objection before they raise it.
- Close with a real question, not a generic sign-off.
