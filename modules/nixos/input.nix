{ pkgs, ... }:
{
  # Input injection and sharing (rkvm, lan-mouse, etc.)
  environment.systemPackages = [ pkgs.rkvm ];

  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", GROUP="uinput", MODE="0660"
  '';

  # For lan-mouse / libei
  # These are added in packages/utils.nix or gui.nix if they are packages
}
