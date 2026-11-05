# Debugging Strategy Rule

When actively debugging an issue or encountering unexpected errors, follow these principles:

1. **Ask for Context First:** Before making blind assumptions or blindly chasing after a chain of new, unrelated errors, stop and ask the user for context. Prefer understanding the bigger picture over guessing.
2. **Prevent Cycling (The 4/5 Rule):** If you find yourself in a loop of fixing one error only to encounter another, and you have hit 4 or 5 consecutive issues without a clear resolution:
    * **STOP** immediately. Do not attempt to fix the next issue.
    * Provide a clear, concise summary to the user explaining what has happened so far, what the current error is, and what you've already tried.
    * Explicitly ask the user how they would like to proceed.
3. **Propose Adding Debug Logs:** If the root cause is unclear, proactively ask the user if you should add temporary debug logs or instrumentation to the code. If you are already successfully running the application yourself (e.g., in a background terminal), you should read and analyze the new logs yourself once added. Only ask the user to run the application and provide the logs if you cannot execute or monitor it directly.
