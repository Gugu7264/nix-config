# Antigravity Delegation Rule

1. **Standing permission:** You may spawn subagents for subtasks on your own judgment, without being asked.
2. **Prefer Antigravity:** When delegating, use the `antigravity` subagent (it runs the task through the `agy` CLI).
3. **Fall back to built-in agents** when the subtask needs Claude Code-only tools (Artifact, MCP tools, harness-tracked file edits, AskUserQuestion), or when `agy` fails or times out.
4. **Verify:** Treat agy's output as a report to check, not as ground truth.
