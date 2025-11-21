{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/boot.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/nix.nix
    ../../modules/nixos/bluetooth.nix
    ../../modules/nixos/sound.nix
    ../../modules/nixos/printing.nix
    ../../modules/nixos/opengl.nix
    ../../modules/nixos/ly.nix
    ../../modules/nixos/maomaowm.nix
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
  ];

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [631];
  };

  boot = {
    kernelParams = [
      ''acpi_osi=!''
      ''acpi_osi=\"Windows 2022\"''
      ''acpi_enforce_resources=lax''
      ''usbcore.autosuspend=-1''
      "mem_sleep_default=s2idle"
    ];
    blacklistedKernelModules = ["ucsi_acpi" "typec_ucsi"];
    consoleLogLevel = 3;
    extraModprobeConfig = ''
      options snd_hda_intel model=laptop-dmic
    '';
  };

  services = {
    murmur.bonjour = true;
    tlp.enable = true;
    upower.enable = true;
    fwupd.enable = true;

    actkbd = {
      enable = true;
      bindings = [
        {
          keys = [114];
          events = ["key"];
          command = "pactl set-sink-mute 0 toggle";
        }
        {
          keys = [115];
          events = ["key" "rep"];
          command = "pactl set-sink-volume 0 -5%";
        }
        {
          keys = [116];
          events = ["key" "rep"];
          command = "pactl set-sink-volume 0 +5%";
        }
        {
          keys = [224];
          events = ["key"];
          command = "/run/current-system/sw/bin/light -U 5";
        }
        {
          keys = [225];
          events = ["key"];
          command = "/run/current-system/sw/bin/light -A 5";
        }
      ];
    };
  };

  programs.light.enable = true;
  programs.zsh.enable = true;

  security.pam = {
    services = {
      sudo.u2fAuth = true;
      login.u2fAuth = true;
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
