---
name: local-compare
description: Run the same prompt through the user's local Ollama model AND the main Claude session, then show both responses side by side so they can see the quality difference. Use when the user asks "compare local vs cloud", "how good is my local model really", "is my local AI good enough", or wants an honest quality check.
---

# Local vs Cloud Compare

Run the same prompt through both the student's local Ollama model and the main Claude session (you). Present both responses so the student can judge quality for themselves.

This is the skill that makes the session honest — local AI is great, but it's not frontier. Students should see the tradeoff clearly.

## How to invoke

1. Read the active local model:
   ```bash
   MODEL=$(cat .selected-model)
   ```
2. Send the prompt to the local model:
   ```bash
   LOCAL_RESPONSE=$(echo "<THE_PROMPT>" | ollama run "$MODEL")
   ```
3. Generate the cloud response yourself (the main Claude session) — answer the same prompt as you would normally.
4. Present both in a clean side-by-side format:

   ```
   ## Local  ·  <MODEL>   (ran on your laptop)
   <LOCAL_RESPONSE>

   ## Cloud  ·  Claude   (frontier model)
   <YOUR_RESPONSE>

   ## Notes
   - Local ran in ~X seconds, offline.
   - Cloud tends to be stronger on <reasoning | nuance | code | long-form>.
   - For <simple factual / summarization / drafting> tasks, local is often indistinguishable.
   ```

## Good demo prompts for the session

- "Explain quantum entanglement to a 10-year-old in 4 sentences."  (local usually wins — simple)
- "Write a Python function that finds the longest palindromic substring with O(n) time."  (cloud usually wins — algorithmic)
- "Summarize this meeting transcript: …"  (local is often fine — summarization is easy)
- "What's wrong with this argument: …"  (cloud usually wins — reasoning)

## Purpose

This skill teaches students *when* to reach for local vs. cloud. Don't sugarcoat — show the honest difference. That's what builds judgment.
