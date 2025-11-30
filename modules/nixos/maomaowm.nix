{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.maomaowm.nixosModules.maomaowm];
  programs.maomaowm.enable = true;
  programs.hyprlock.enable = true;
}
