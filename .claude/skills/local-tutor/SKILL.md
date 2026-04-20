---
name: local-tutor
description: Interactive learning with the local model. Four teaching modes — explain (clear intro to a topic), quiz (generates a quiz and grades answers), feynman (asks YOU to explain, then critiques your explanation), socratic (asks questions instead of answering to help you think it through). Use when the user says "teach me X", "quiz me on", "help me understand", "learn about", "I want to study".
---

# Local Tutor — interactive learning

Four teaching modes, each suited to a different stage of learning:

| Action | Stage |
|---|---|
| `explain <topic>` | New to the topic — give me a clean intro |
| `quiz <topic> [n]` | I think I know it — test me (default 5 questions) |
| `feynman <topic>` | Prove I know it — I'll explain, you critique |
| `socratic <topic>` | Help me think — lead me with questions, don't answer |

## Examples

```bash
./ai local-tutor explain "How DNS works"
./ai local-tutor quiz transformers 10
./ai local-tutor feynman "Bayes' theorem"
./ai local-tutor socratic "Why is software estimation so hard?"
```
