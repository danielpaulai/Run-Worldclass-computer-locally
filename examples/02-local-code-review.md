# Example: `local-code review` on a shell script

**Model:** `qwen2.5:7b`
**Input:** `chat.sh` (the ~30-line launcher in this repo)
**Command:** `./ai local-code review chat.sh`

## What came out

### Review of the Shell Script

#### (1) Bugs or Risks
- **Potential Issues with `curl` Command:** The `curl` command is not always a reliable way to check if a service is running. It might fail due to network issues, firewall rules, etc.
- **Assumption on Service Port:** Assumes that Ollama runs on `localhost:11434`. This could be risky if the service uses a different port or the configuration is changed.

#### (2) Improvements
- **Use of `-o` Option with `curl`:** Use `-o /dev/null` to suppress output and error messages.
- **Graceful Handling of Service Startup:** Add a loop or retry mechanism in case Ollama fails to start.
- **Logging Improvements:** Log the startup process more clearly.
- **Error Messages:** Improve error messages and add logging to capture failures.

#### (3) What It Does Well
- Checks if a model is selected.
- Gracefully starts the Ollama service if it's not running.

#### Suggested Improvements
The model then rewrote the whole script with: retry loop for service startup, `-o /dev/null` on curl, explicit OS fallback, timeout check after start.

## Teacher's note

**Quality: genuinely good.** The model found real issues (missing timeout retry, no OS fallback), and the rewritten version was an actual improvement. This is the category of work where a local 7B model competes with cloud models.

**Use this as a demo moment:** Show students the original script, then run `./ai local-code review`, then scroll through the model's output side-by-side. The "magic" lands.

**Time:** ~35 seconds to generate ~400 words of review plus a rewritten script.
