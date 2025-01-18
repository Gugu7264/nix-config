{ inputs
, pkgs
, modules
, pkgs-local
, ...
}:
let
  inherit (inputs) home-manager;
  rootPath = ../.;
in
{
  home-manager.useGlobalPkgs = true;
  "pie" = home-manager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {
      username = "abel.chartier";
      rootPath = rootPath;
      stateVersion = "23.05";
      inherit pkgs-local;
    };

    modules = [
      ./pie.nix
    ] ++ modules;
  };
}
