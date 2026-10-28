{ pkgs, ... }:
{
  imports = [
    ./dev.nix
    ./utils.nix
    ./gui.nix
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 14d --keep 3";
    };
    flake = "/home/gurvanbk/nix-config";
  };
}
