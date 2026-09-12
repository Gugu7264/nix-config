{ inputs, ... }:
{
  imports = [
    inputs.dank-greeter.nixosModules.default
  ];

  services = {
    accounts-daemon.enable = true;
  };

  programs.dms-greeter = {
    enable = true;
    compositor.name = "niri";
    configHome = "/home/gurvanbk";
  };
}
