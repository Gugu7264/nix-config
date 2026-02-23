{
  config,
  pkgs,
  lib,
  ...
}:
{
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = false;
    setSocketVariable = true;
  };
}
