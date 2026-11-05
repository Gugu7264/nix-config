# No Global Package Installation Rule

Never install packages into the global system or user profile:

1. **Nix:**
   - Do NOT run `nix-env -i`, `nix profile install`, or alter system-wide packages.
   - Always use local project development environments (`nix develop` or devShells declared in `flake.nix` / `shell.nix`).
2. **Node / npm / npx:**
   - Do NOT run `npm install -g`, `yarn global`, or `pnpm add -g`.
   - Do NOT run `npx` commands that download or mutate global tool caches outside a local project scope.
3. **Other Package Managers (pip, cargo, etc.):**
   - Keep dependencies confined to project-local virtual environments or project trees; never install packages globally.
