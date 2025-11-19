{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "rounded-nord-dark";
    extraConfig = {
      show-icons = true;
    };
  };
}
