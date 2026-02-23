{
  config,
  pkgs,
  lib,
  ...
}: {
  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "discord"
      "slack"
      "vscode"
      "idea"
      "clion"
      "phpstorm"
      "steam"
      "steam-unwrapped"
      "plex-desktop"
      "datagrip"
      "hplip"
      "pantum-driver"
    ];

  programs.nix-ld.enable = true;
  documentation.dev.enable = true;
}
