# Nix Develop Rule

When you need to execute a command (like a build tool, compiler, or script) and it is unavailable or fails with a "command not found" error:
1. Check if a Nix development shell is available in the workspace (look for `flake.nix` or `shell.nix`).
2. If a devShell exists, retry the execution by wrapping the command with `nix develop`:
   `nix develop --command <original-command>`
3. For flakes, you can also try running specific targets using `nix run`.

Always prioritize using the project's Nix environment over asking the user to manually install missing global dependencies.
