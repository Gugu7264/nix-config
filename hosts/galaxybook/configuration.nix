# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.maomaowm.nixosModules.maomaowm
    ./packages.nix
    ./ocaml.nix
    ./sound.nix
    ../../modules/neovim.nix
  ];

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = false;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "discord"
      "slack"
      "vscode"
      "idea-ultimate"
      "steam"
      "steam-unwrapped"
      "plex-desktop"
    ];

  programs.nix-ld.enable = true;

  boot = {
    # Bootloader.
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelParams = [
      ''acpi_osi=!''
      ''acpi_osi=\"Windows 2022\"''
      ''acpi_enforce_resources=lax''
      ''usbcore.autosuspend=-1''

      "mem_sleep_default=s2idle" # should fix sleeping crashing the computer
    ];
    blacklistedKernelModules = ["ucsi_acpi" "typec_ucsi"]; # fixes charging !!! (kernelParams required too?)
    consoleLogLevel = 3; # 3 = KERN_ERR, 4 = KERN_WARNING
  };

  services = {
    # Power management
    murmur.bonjour = true;
    tlp.enable = true;
    upower.enable = true;

    # USB Rules
    fwupd.enable = true;
    udev.packages = [pkgs.chromium];
    # Automatically change MODE of micro:bit
    udev.extraRules = ''
      SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="0666"
    '';

    # Enable bluetooth
    blueman.enable = true;

    # Fn-keys bindings
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

    # Manage Desktop Environment + Window Manager
    displayManager = {
      defaultSession = "hyprland";
      autoLogin = {
        enable = false;
        user = "gurvanbk";
      };
      ly = {
        enable = true;
      };
    };
  };

  networking.hostName = "nixos"; # Define your hostname.

  #### EDITOR WITH FLAKE #####

  editor.neovim.enable = true;

  #### END EDITOR WITH FLAKE #####

  # Enable networking
  networking.networkmanager.enable = true;

  virtualisation = {
    docker.enable = true;
    docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    libvirtd.enable = true;
  };

  # Manage bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  documentation.dev.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  # Configure console keymap
  # console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gurvanbk = {
    isNormalUser = true;
    description = "Gurvan BK";
    extraGroups = ["networkmanager" "wheel" "input" "video" "docker" "dialout" "plugdev"];
    shell = pkgs.zsh;
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users = {
      "gurvanbk" = import ./home.nix;
    };
    sharedModules = [
      inputs.maomaowm.hmModules.maomaowm
    ];
  };

  programs = {
    # Screen brightness
    light.enable = true;

    maomaowm.enable = true;
    hyprlock.enable = true;
  };

  security.pam.services = {
    sudo.u2fAuth = true;
    login.u2fAuth = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
