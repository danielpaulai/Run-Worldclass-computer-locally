---
name: local-agent
description: Autonomous task runner that breaks a goal into steps and executes them using the local model. Four actions — plan (break goal into steps), run (execute plan with human confirm between steps), verify (check result against goal), checkpoint (save state). SAFETY - the agent only proposes shell commands and writes files within a working directory; it never runs destructive commands (rm, sudo, curl |sh) without explicit confirmation. Use when the user says "autonomously do X", "agent mode", "plan and execute", "figure this out yourself".
---

# Local Agent — autonomous task runner

Gives the local model basic agentic abilities: break a goal into steps, propose commands/files, and execute them with human-in-the-loop confirmation.

| Action | Does |
|---|---|
| `plan <goal>` | Breaks the goal into 3-7 concrete steps; each step is either a shell command or a file-write |
| `run <plan-file>` | Walks through the plan, asking confirmation before each step |
| `verify <result-dir>` | Asks the model to check whether the goal was met |
| `checkpoint` | Saves current agent state for resume |

## Safety — read this before trusting an agent

This agent is conservative on purpose:

- **Never** runs `rm -rf`, `sudo`, `curl | sh`, anything that modifies system state outside `./.agent-workspace/`.
- **Asks confirmation** before every command. Say `n` at any step to abort.
- **All output saved** to `.agent-workspace/<run-id>/` — the work happens there.

## Examples

```bash
./ai local-agent plan "Create a Python script that fetches the current NASA APOD image URL and saves it."
./ai local-agent run .agent-workspace/xyz/plan.md
./ai local-agent verify .agent-workspace/xyz
```
