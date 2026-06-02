{ pkgs, ... }:
{
  imports = [
    ./dev.nix
    ./utils.nix
    ./gui.nix
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/gurvanbk/nix-config";
  };

  # SSHFS / GSSAPI related
  programs.ssh.package = pkgs.openssh_gssapi;
}
