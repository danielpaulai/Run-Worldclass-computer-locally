---
name: local-code
description: Private coding assistant using the local model. Six actions — explain (walk through a file or function), review (critique for bugs/style), refactor (suggest improvements), test-gen (generate tests), doc (add docstrings), debug (analyze an error message). Use whenever the user wants code help for proprietary or sensitive code they don't want to send to the cloud. Trigger phrases - "explain this code", "review my code", "refactor", "generate tests", "write docs for this", "debug this error", "code privately".
---

# Local Code — private coding assistant

| Action | Does |
|---|---|
| `explain <file>` | Walks through what the code does |
| `review <file>` | Critiques for bugs, style, edge cases |
| `refactor <file>` | Suggests improvements with rewritten snippets |
| `test-gen <file>` | Generates unit tests for the code |
| `doc <file>` | Adds docstrings / inline comments |
| `debug <error>` | Analyzes an error message and suggests fixes |

All private — your code never leaves your machine.

## Examples

```bash
./ai local-code explain src/auth.py
./ai local-code review src/payment.ts
./ai local-code refactor ./legacy.js
./ai local-code test-gen ./utils.py
./ai local-code doc ./parser.go
echo "TypeError: Cannot read property 'map' of undefined at line 42" | ./ai local-code debug
```
