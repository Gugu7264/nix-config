{ config, pkgs, lib, ... }:
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    theme = "rounded-nord-dark";
    extraConfig = {
      show-icons = true;
    };
  };
}
