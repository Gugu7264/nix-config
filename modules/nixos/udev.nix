{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.udev.packages = [ pkgs.chromium ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="0666"
  '';
  services.pcscd.enable = true;
}
