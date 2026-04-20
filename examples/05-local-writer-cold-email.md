# Example: `local-writer draft` — cold email

**Model:** `qwen2.5:7b`
**Prompt:** *Draft a cold outreach email. Context: I'm Priya, freelance marketing consultant. Reaching out to the head of marketing at a mid-sized B2B SaaS company. Offer a 30-minute positioning audit. Warm but professional. Short. Open with something specific, not a generic hook. 120 words max.*

## What came out

> **Subject:** Unlock Your Company's Full Potential with a Quick Positioning Audit
>
> Hi [Recipient's Name],
>
> I hope this message finds you well. My name is Priya, and I specialize in helping B2B SaaS companies like yours elevate your brand positioning through strategic marketing. Given the competitive landscape, I believe a focused 30-minute audit could provide actionable insights to enhance your market presence.
>
> Would you have 30 minutes next week to discuss how we can achieve this together?
>
> Best regards,
> Priya

## Teacher's note

**Quality: weak.** The model ignored the explicit instruction *"open with something specific, not a generic hook"* and led with **"I hope this message finds you well."** That's the archetype of a generic opener. It also used the clichéd "unlock your full potential" headline.

**This is the right moment to introduce the honest tradeoff:**

| Task | Local 7B model | Cloud model |
|---|---|---|
| Summarize | Strong | Strong |
| Code review | Strong | Strong |
| Factual Q&A | Mixed (hallucinates) | Strong |
| Follow a nuanced instruction | **Weak** | Strong |
| Write with real voice | **Weak** | Better |

**The workaround:** give the local model more concrete examples in the prompt (few-shot), or iterate — send the bad draft back with "the opener is generic, rewrite with a specific industry detail." Usually the second pass is much better.

**Time:** ~11 seconds.
