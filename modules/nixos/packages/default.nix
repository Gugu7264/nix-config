{ pkgs, ... }:
{
  imports = [
    ./dev.nix
    ./utils.nix
    ./gui.nix
  ];

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 14d --keep 3";
    };
    flake = "/home/gurvanbk/nix-config";
  };

  # SSHFS / GSSAPI related
  programs.ssh.package = pkgs.openssh_gssapi;

  systemd.tmpfiles.rules = [
    # make cpu info world-readable for btop
    "Z /sys/class/powercap/intel-rapl:0/energy_uj 0444 root root - -"
  ];
}
