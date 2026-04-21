# Example: Workflow `daily-brief` end-to-end

**Model:** `qwen2.5:7b`
**Command:** `./ai local-workflow run daily-brief`
**Input:** Three real journal entries in `.journal/` (Fri/Sat/Sun 2026-04-17 to 19)

## What the workflow does

Two chained steps:

1. `./ai local-journal reflect` — reads the last five journal entries and offers pattern observations
2. `./ai local-ai persona engineer "…"` — takes the reflection as context and produces a prioritized action list for today

## Real output

### Step 1 — reflection on three days of journal entries

> **Pattern Notice:** There's a recurring theme of self-improvement and reflection in your entries, which shows a commitment to personal and professional growth.
>
> **Thing Worth Sitting With:** The guilt you feel for not working during the first real Sunday off in five weeks. It's important to acknowledge this feeling as it reflects on your work-life balance and what you value.
>
> **Honest, Specific Question:** Given that you've been doing busywork dressed up as strategy, have you considered whether there are specific tasks or projects that could be delegated or eliminated to free up more time for strategic thinking and direct customer feedback?

### Step 2 — today's three highest-leverage things

> 1. **Prioritize Customer Feedback Sessions** — This directly addresses your need for strategic thinking and insight into customer needs.
> 2. **Identify and Delegate Non-Essential Tasks** — Freeing up time by delegating or eliminating busywork allows you to focus on higher-value activities.
> 3. **Reflect on Work-Life Balance** — Addressing guilt and finding a better balance can improve overall productivity and well-being, indirectly boosting strategy effectiveness.

## Teacher's note

**Quality: genuinely useful.** The reflection picked up two real threads from the journal entries (the "busywork dressed up as strategy" phrase Tomás used on Saturday, and the Sunday-off guilt). It didn't hallucinate content. The question it proposed was pointed, not generic.

The Step 2 action list is weaker — more abstract than it could be. The model turned "prioritize customer feedback" into the bullet, but didn't say *which three churned customers to call today*. That's the gap: 7B models are good at synthesis, weaker at concretization.

**Time:** ~25 seconds total (both steps).

**Two bugs were found and fixed by running this workflow:**

1. `reflect.sh` didn't handle repo paths with spaces — the repo directory name has spaces in it, which broke `cat $RECENT`.
2. `persona.sh` ignored stdin when given a prompt as argv, so the reflection output was lost between steps.
3. `ai_ask_system` in `lib/common.sh` used a broken sed regex that matched `"content":"X","role":` but Ollama returns `"role":"...","content":"..."`. Fixed by switching to Python JSON parsing.

All three fixes are in the repo — not cosmetic, they were real blockers.
