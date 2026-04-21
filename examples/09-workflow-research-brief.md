# Example: Workflow `research-brief` end-to-end

**Model:** `qwen2.5:7b`
**Command:** `./ai local-workflow run research-brief "What are the key tradeoffs a small business owner faces when choosing between a local LLM and a cloud LLM for daily work?"`

## What the workflow does

Two chained steps, but step 1 is itself a 3-phase orchestrator:

1. `local-research full` — internally runs **plan → gather → synthesize**:
   - **plan:** breaks the question into 8 sub-questions
   - **gather:** answers each sub-question with the model
   - **synthesize:** combines findings into a structured trade-offs report
2. `local-ai persona writer "…"` — turns the full report into a 1-page executive summary following a strict format (decision, 3 bullets, 1 risk, 1 open question, max 250 words)

## Step 1 — The 8 sub-questions it generated

1. Cost considerations for small business owners choosing between local and cloud
2. How data privacy concerns differ
3. Technical requirements small businesses must meet for each
4. Performance and reliability comparison
5. Scalability differences
6. Environmental impacts
7. Scenarios where each wins
8. Long-term implications for business growth and sustainability

(All sub-questions got a real answer — artifacts saved to `.research/what-are-the-key-tradeoffs-.../`)

## Step 1 — Final synthesized report (excerpt)

Well-structured trade-off analysis covering four axes — Security vs. Convenience, Cost vs. Performance, Latency vs. Scalability, Customization vs. Standardization — plus a long-term implications section on Customer Trust, Operational Efficiency, Resource Allocation, Innovation & Adaptability.

## Step 2 — Executive summary (the deliverable)

> **Decision:** For small businesses prioritizing security and real-time performance, a local Large Language Model (LLM) is recommended. For those needing flexibility, scalability, and ease of use, a cloud-based LLM is the better choice.
>
> - **Supporting Bullet 1:** Local models offer higher security and enhanced data privacy, building customer trust over time. However, they require significant upfront investment in hardware.
> - **Supporting Bullet 2:** Cloud models are more cost-effective initially, with flexible pay-as-you-go pricing, making them ideal for rapid growth. They also provide easy scalability and real-time performance improvements through standardized updates.
> - **Supporting Bullet 3:** Local LLMs can be finely tuned to specific business needs, providing a competitive edge but at the cost of higher initial setup efforts.
>
> **Risk:** Over-reliance on cloud services may expose businesses to ongoing subscription costs and potential data breaches. Conversely, local models might strain budgets due to hardware requirements.
>
> **Open Question:** How can small businesses balance the trade-offs between security, cost, and performance to ensure long-term sustainability?

## Teacher's note

**Quality: this is the most impressive output of any test so far.** Because the work happens in phases (plan → gather → synthesize → exec-summary), each stage sees a narrower problem. The model doesn't have to hold the whole thing in its head.

Notable wins:
- **It followed the exec-summary format exactly** (lead with decision, 3 bullets, risk, open question, under 250 words). Earlier single-shot tests showed the model ignoring instructions — but here, because the input is clean (a pre-structured report), it stayed on-script.
- **The sub-questions it generated cover real trade-off axes** — cost, privacy, technical, performance, scalability, environment, scenarios, long-term. This is competent research scoping.
- **The synthesis is well-structured** — four named axes with implications for each. Not just a flat list.

Weaker parts:
- Some phrasing is generic ("building customer trust over time") — the inherent weakness of small models on creative voice.
- Doesn't cite specific numbers or examples — it's all qualitative.

**Time:** ~3 minutes total on `qwen2.5:7b` (8 sub-questions + synthesis + exec summary).

**This is the workflow that wins your session.** Compared to a single-shot "write me a research report" prompt, the orchestrated version produces noticeably better structure and coverage — and ends with exactly the artifact the student needs (the 1-page exec summary) rather than a wall of text.
