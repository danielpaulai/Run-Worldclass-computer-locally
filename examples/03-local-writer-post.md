# Example: `local-writer persona writer` — LinkedIn post

**Model:** `qwen2.5:7b`
**Prompt:** *Draft a 120-word LinkedIn post for a solo SaaS founder. Topic: we cut customer onboarding from 14 days to 3 days by REMOVING a config step. Hook with the counter-intuitive move — we added work to ourselves, not to the user. No emojis.*

## What came out

> As a solo SaaS founder, I've always sought ways to streamline our process without compromising quality. Recently, we took on a task that might seem counterintuitive: **adding a configuration step** during customer onboarding. Surprisingly, this move shaved 11 days off the onboarding timeline, reducing it from 14 days to just 3! By investing time in ourselves to ensure robust initial setup, we've empowered users to hit the ground running faster. This approach might not be about adding steps for you, but rather ensuring that every step counts—demonstrating a commitment to excellence and user satisfaction.

## Teacher's note

**Quality: medium, with a real bug.** The model **flipped the logic** — I asked about *removing* a config step, and the model wrote about *adding* one. It also leaned on generic phrasing ("commitment to excellence and user satisfaction").

**Why this matters for your session:** A 7B model is a first draft, not a final draft. It's fast, free, and private — but it needs a human editor. This is the honest tradeoff. Cloud models like Claude and GPT-4 would catch the inversion.

**The teaching move:** After running this, ask students to spot what the model got wrong. This builds the right mental model of where local AI shines (summarization, code review) vs. where it still needs a hand (nuanced instruction-following, creative writing).

**Time:** ~12 seconds.
