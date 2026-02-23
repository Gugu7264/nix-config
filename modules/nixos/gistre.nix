{
  config,
  pkgs,
  lib,
  ...
}: {
  environment.systemPackages = with pkgs; [
    mosquitto
    kicad
    node-red
    arduino-ide
  ];
}
