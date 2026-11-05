# Git Commit Signing and Configuration Preservation Rule

When working with Git in repositories:

1. **Preserve Git Configuration:**
   - NEVER modify local or global Git configurations (do NOT edit `.git/config`, `~/.gitconfig`, or run `git config` to alter signing, credentials, or remotes).

2. **Mandatory GPG Commit Signing:**
   - All commits must be signed with GPG.
   - NEVER bypass GPG signing using `--no-gpg-sign` or similar flags.

3. **TTY / Pinentry Blocking:**
   - In automated or subagent environments, pinentry and hardware key interactions block on TTY.
   - When a commit or push requires GPG signature or hardware key confirmation (YubiKey / smartcard), do NOT bypass it or let background processes hang indefinitely.
   - Stop and inform the user immediately, providing the exact command so they can run `git commit` or `git push` by hand in their interactive terminal.
