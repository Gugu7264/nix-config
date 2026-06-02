{ pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/mic-led.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/opengl.nix
    ../../modules/nixos/greet.nix
    ../../modules/nixos/docker.nix
    ../../modules/nixos/libvirt.nix
    ../../modules/nixos/udev.nix
    ../../modules/nixos/gnupg.nix
    ../../modules/nixos/packages/default.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/avahi.nix
    ../../modules/nixos/niri.nix
    ../../modules/nixos/gistre.nix
    ../../modules/nixos/attic.nix
    ../../modules/nixos/security.nix
    ../../modules/nixos/power.nix
    ../../modules/nixos/input.nix
    ../../modules/nixos/earlyoom.nix
    ../../modules/nixos/desktop.nix
  ];

  networking = {
    hostName = "thinkpad-p14s";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 631 ];
  };

  boot = {
    initrd = {
      systemd.enable = true;
      luks.fido2Support = false;
    };
  };

  services.murmur.bonjour = true;

  programs.zsh.enable = true;

  users.users.gurvanbk = {
    isNormalUser = true;
    description = "Gurvan BK";
    extraGroups = [
      "networkmanager"
      "wheel"
      "input"
      "video"
      "docker"
      "dialout"
      "plugdev"
      "libvirtd"
      "uinput"
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.overlays = [
    (final: prev: {
      xdg-desktop-portal = prev.xdg-desktop-portal.overrideAttrs (old: {
        doCheck = false;
      });

      jupyter-server = prev.jupyter-server.overrideAttrs (old: {
        doCheck = false;
      });
      pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
        (python-final: python-prev: {
          django = python-prev.django.overridePythonAttrs (old: {
            doCheck = false;
          });
          twisted = python-prev.twisted.overridePythonAttrs (old: {
            doCheck = false;
          });
          jupyter-server = python-prev.jupyter-server.overridePythonAttrs (old: {
            doCheck = false;
          });
        })
      ];
    })
  ];

  nix.settings = {
    max-jobs = "auto";
    cores = 0;
  };
  zramSwap.enable = true;

  system.stateVersion = "25.05";
}
