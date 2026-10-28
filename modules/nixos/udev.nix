{ pkgs, ... }:
{
  services = {
    udev = {
      packages = with pkgs; [
        openocd
      ];
      extraRules = ''
        SUBSYSTEM=="usb", ATTRS{idVendor}=="0483", MODE="0666"
      '';
    };
    pcscd.enable = true;
  };
}
