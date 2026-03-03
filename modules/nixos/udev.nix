{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.udev.packages = with pkgs; [
    chromium
    openocd
  ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="0666"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", MODE="0666"
  '';
  services.pcscd.enable = true;
}
