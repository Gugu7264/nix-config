{ lib, ... }:
{
  nix.settings = {
    experimental-features = "nix-command flakes";
  };
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "1password-gui"
      "discord"
      "slack"
      "vscode"
      "idea"
      "clion"
      "steam"
      "steam-unwrapped"
      "plex-desktop"
      "hplip"
      "pantum-driver"
      "stm32cubemx"
      "lens-desktop"
      "quartus-prime-lite"
      "quartus-prime-lite-unwrapped"
    ];

  programs.nix-ld.enable = true;
  services.envfs.enable = true;
  documentation.dev.enable = true;
}
