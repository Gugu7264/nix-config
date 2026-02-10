{pkgs, ...}: {
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
    ../../modules/nixos/packages.nix
    ../../modules/nixos/steam.nix
    ../../modules/nixos/avahi.nix
    ../../modules/nixos/mysql.nix
    ../../modules/nixos/ocaml.nix
    ../../modules/nixos/firefox.nix
    ../../modules/nixos/niri.nix
  ];

  networking = {
    hostName = "thinkpad-p14s";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [631];
  };

  boot = {
    initrd = {
      systemd.enable = true;
      luks.fido2Support = false; # disable old support
    };
  };

  services = {
    murmur.bonjour = true;
    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 75;
        STOP_CHARGE_THRESH_BAT0 = 80;
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        PLATFORM_PROFILE_ON_AC = "performance";
        PLATFORM_PROFILE_ON_BAT = "low-power";
      };
    };
    upower.enable = true;
    fwupd.enable = true;
    fprintd.enable = true;
  };

  programs.light.enable = true;
  programs.zsh.enable = true;

  security.pam = {
    services = {
      sudo.u2fAuth = true;
      login.u2fAuth = true;
      hyprlock = {
        text = ''
          auth       sufficient     pam_unix.so try_first_pass likeauth nullok
          auth       sufficient     pam_fprintd.so
          auth       include        system-auth

          account    include        system-auth
          password   include        system-auth
          session    include        system-auth
        '';
      };
    };
    u2f.settings.cue = true;
  };

  users.users.gurvanbk = {
    isNormalUser = true;
    description = "Gurvan BK";
    extraGroups = ["networkmanager" "wheel" "input" "video" "docker" "dialout" "plugdev"];
    shell = pkgs.zsh;
  };

  nixpkgs.overlays = [
    (final: prev: {
      xdg-desktop-portal = prev.xdg-desktop-portal.overrideAttrs (old: {
        doCheck = false;
      });

      pythonPackagesExtensions =
        prev.pythonPackagesExtensions
        ++ [
          (python-final: python-prev: {
            django = python-prev.django.overridePythonAttrs (old: {
              doCheck = false;
            });
            twisted = python-prev.twisted.overridePythonAttrs (old: {
              doCheck = false;
            });
          })
        ];
    })
  ];

  system.stateVersion = "25.05";
}
