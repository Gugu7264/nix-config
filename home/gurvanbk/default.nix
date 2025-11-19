{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/neovim.nix
    ../../modules/home-manager/maomaowm.nix
    ../../modules/home-manager/waybar.nix
    ../../modules/home-manager/rofi.nix
    inputs.maomaowm.hmModules.maomaowm
  ];

  home = {
    username = "gurvanbk";
    homeDirectory = "/home/gurvanbk";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
