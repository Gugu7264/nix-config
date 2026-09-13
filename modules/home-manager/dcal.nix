{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dank-calendar.homeModules.default
  ];

  programs.dank-calendar = {
    enable = true;
    systemd.enable = true;
  };

  home.packages = [
    pkgs.jq
  ];
}
