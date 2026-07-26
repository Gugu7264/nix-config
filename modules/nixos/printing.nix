{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    browsing = true;
    drivers = [
      pkgs.hplipWithPlugin
      pkgs.pantum-driver
    ];
  };
}
