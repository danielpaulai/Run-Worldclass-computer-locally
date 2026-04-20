# Example: The hallucination moment — `local-ai ask`

**Model:** `qwen2.5:7b`
**Prompt:** *What is Ollama? Answer in exactly 3 sentences, plain language, for a small business owner.*

## What came out

> Ollama is an artificial intelligence tool designed to help businesses automate tasks and improve productivity. It uses natural language processing to understand and respond to queries, making it easier for users to get information quickly. For small business owners, Ollama can assist with managing operations and decision-making by providing insights from data analysis.

## What's wrong with this answer

**Everything.** Ollama is not an AI — it is a **runtime** that lets you run AI models locally. It doesn't "automate tasks," "understand queries," or "provide insights." The model confidently hallucinated a plausible-sounding but completely wrong definition.

## Teacher's note — DEMO THIS EARLY

**This is the single most important demo in your whole session.** Run this prompt live, read the confident answer out loud, then reveal the truth.

Students need to internalize:

> **A local 7B model doesn't know what it doesn't know.** It will make things up, fluently and confidently. This is true of all small models, and somewhat true of all AI.

**Rule of thumb students should leave with:**
- Use local AI for tasks you can *verify* (summarize a doc you can re-read, review code you can test, draft an email you'll edit).
- Don't use it for facts you don't already know the shape of, unless you can cross-check.

**Time:** ~7 seconds.
