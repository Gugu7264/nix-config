# NixOS Configuration

Personal NixOS and Home Manager configuration using Nix Flakes.

* **Target Host:** ThinkPad P14s (AMD Gen 5) (`#thinkpad-p14s`)
* **Window Manager:** Niri (Wayland)
* **Editor:** Nixvim (Neovim)
* **Shell:** Zsh + Powerlevel10k + Atuin

---

## 🚀 Quick Start

To apply system changes:

```bash
# Rebuild and switch configuration
sudo nixos-rebuild switch --flake .#thinkpad-p14s

# Update flake inputs
nix flake update
```

---

## 🔑 YubiKey Setup & Git Integration

This configuration uses a YubiKey for:
1. **GPG Commit & Tag Signing**
2. **SSH Authentication (Git push/pull & remote access)**
3. **FIDO2 LUKS Disk Encryption Unlock**

### Architecture

* **Smartcard Daemon:** `services.pcscd.enable = true` in `modules/nixos/udev.nix`.
* **GPG Agent:** Configured in `modules/nixos/gnupg.nix` with `enableSSHSupport = true` and `pinentryPackage = pkgs.pinentry-curses`.
* **SSH Socket:** `zsh` exports `SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)`.
* **Git Signing:** `programs.git.signing.signByDefault = true` in `modules/home-manager/git.nix`.

---

### Initial Setup on a New Machine / Reinstall

When setting up on a fresh machine or if GPG key stubs are missing:

1. **Plug in your YubiKey**.
2. **Import your public key** (links the GPG secret key stubs to the card):
   ```bash
   curl -s https://github.com/Gugu7264.gpg | gpg --import
   ```
3. **Read the smartcard status** to let GPG recognize the card stubs:
   ```bash
   gpg --card-status
   ```
4. **Verify the secret key stub is registered** (`sec>` indicates card stub):
   ```bash
   gpg -K
   ```
5. **Verify SSH authentication key is exposed**:
   ```bash
   ssh-add -l
   ```

---

### Daily Usage with Git

* **Committing:**
  Run `git commit` (or alias `gc`). Git will automatically invoke GPG and prompt for your YubiKey PIN using `pinentry-curses` (and a physical touch if configured).
* **Pushing / Pulling over SSH:**
  When using SSH remotes (`git@github.com:...`), SSH routes authentication to the YubiKey Auth subkey via `gpg-agent`.

---

### Useful Commands & Troubleshooting

| Action | Command |
|---|---|
| Check YubiKey OpenPGP card status | `gpg --card-status` |
| Check GPG secret key stubs | `gpg -K` |
| List SSH keys provided by YubiKey | `ssh-add -l` |
| Check YubiKey hardware status | `ykman info` |
| Restart GPG / Smartcard agent | `gpgconf --kill gpg-agent` |
| Test SSH connection to GitHub | `ssh -T git@github.com` |

---

## 🔒 Disk Encryption (FIDO2)

The root filesystem is encrypted using LUKS2 and unlocked during initrd via systemd and FIDO2:

* Configuration in `hosts/thinkpad-p14s/hardware-configuration.nix`:
  ```nix
  boot.initrd.luks.devices."cryptroot" = {
    device = "/dev/disk/by-uuid/<UUID>";
    crypttabExtraOpts = [ "fido2-device=auto" ];
  };
  ```

