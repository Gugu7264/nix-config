{ pkgs, ... }:
{
  # SSHFS / GSSAPI related
  programs.ssh.package = pkgs.openssh_gssapi;
  nixpkgs.overlays = [
    (_: prev: {
      sshfs = prev.sshfs.override {
        callPackage = prev.newScope {
          openssh = pkgs.openssh_gssapi;
        };
      };
    })
  ];
}
