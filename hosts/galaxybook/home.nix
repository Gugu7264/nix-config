{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home/shell.nix
    ./home/maomaowm.nix
  ];
  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "gurvanbk";
    homeDirectory = "/home/gurvanbk";
    stateVersion = "24.11"; # READ THE DOCS BEFORE CHANGING, REALLY !!!!!!!
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
