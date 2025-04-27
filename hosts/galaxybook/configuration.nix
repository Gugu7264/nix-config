# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ../../modules/neovim.nix
    ];

  nix.settings.experimental-features = "nix-command flakes";
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelParams = [
    ''acpi_osi=!''
    ''acpi_osi=\"Windows 2022\"''
    ''acpi_enforce_resources=lax''
    ''usbcore.autosuspend=-1''
#   All of the above seem to fix USB-C charging

#    ''acpi_osi=!''
#    ''acpi_osi="Windows 2022"'' # fixes charging on Archlinux, maybe here too?
    "mem_sleep_default=s2idle" # should fix sleeping crashing the computer
    "snd-intel-dspcfg.dsp_driver=1"
  ];
  # boot.blacklistedKernelModules = [ "snd_pcsp" ]; # Disable dummy sound output (pc_speaker "audio card")
  # boot.blacklistedKernelModules = [ "ucsi_acpi" "typec_ucsi" "batt_sbs" "batt_sbp" "sbs_battery" ]; # fixes charging, with too much modules disabled
  boot.blacklistedKernelModules = [ "ucsi_acpi" "typec_ucsi" ]; # fixes charging !!! (kernelParams requiredt too?)

  # Power management
  services.tlp = {
    enable = true;
  };

  services.fwupd.enable = true;
  services.udev.packages = [ pkgs.chromium ];
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE="0666"
  '';

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

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

  # Enable sound
  services.pulseaudio.enable = true;
  services.pipewire = {
    enable = false;
   # alsa.enable = true;
    #alsa.support32Bit = true;
    #pulse.enable = true;
  };

  # Manage bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  # Screen brightness
  programs.light.enable = true;
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 114 ]; events = [ "key" ]; command = "pactl set-sink-mute 0 toggle"; }
      { keys = [ 115 ]; events = [ "key" "rep" ]; command = "pactl set-sink-volume 0 -5%"; }
      { keys = [ 116 ]; events = [ "key" "rep" ]; command = "pactl set-sink-volume 0 +5%"; }
      { keys = [ 224 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -U 5"; }
      { keys = [ 225 ]; events = [ "key" ]; command = "/run/current-system/sw/bin/light -A 5"; }
    ];
  };

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
  console.keyMap = "fr";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gurvanbk = {
    isNormalUser = true;
    description = "Gurvan BK";
    extraGroups = [ "networkmanager" "wheel" "input" "video" "docker" "dialout"  "plugdev" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Applications
    nodejs_22 # For coc plugin
    # (import ./vim.nix) # Custom editor
    alacritty # Terminal emulator
    rofi-wayland # Application chooser
    firefox
    _1password-gui
    thunderbird
    signal-desktop
    whatsapp-for-linux

    hyprlock
    dunst # notification manager
    tree # command
    htop # command
    lxqt.lxqt-policykit
    wl-clipboard
    sddm-sugar-dark

    waybar # Status bar
    adwaita-icon-theme # Cursor icons
    pavucontrol # Sound control
    pamixer # Sound control
    libnotify # Send notifications

    # Development related
    bat
    git
    gcc
    gnumake
    valgrind
    gdb
    clang-tools
    man-pages
    man-pages-posix
    tldr # Simplified man pages
    pre-commit
    ninja # meson dependancy
    meson
    unzip
    jupyter
    cmake
    pkg-config
    openssl
    curlFull
    hyperfine
    automake
    autoconf
    autoconf-archive
    ghc

    # AFS connection
    krb5
    sshfs
    openssh_gssapi

    # ZSH
    zsh-powerlevel10k # theme
    zsh-syntax-highlighting
    zsh-autosuggestions

    # Others
    discord
    imagemagick
    chromium
    vscode
    hyprshot # screenshots

    python312Packages.numpy
    python312Packages.scipy
    yaml-cpp
  ];

  # Open links in firefox by default
  environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.firefox}/bin/firefox";
  xdg.mime.enable = true;
  xdg.mime.defaultApplications = {
    "text/html" = "firefox.desktop";
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/about" = "firefox.desktop";
    "x-scheme-handler/unknown" = "firefox.desktop";
  };

  # Manage Desktop Environment + Window Manager
  services.displayManager = {
    defaultSession = "hyprland";
    autoLogin = {
      enable = false;
      user = "gurvanbk";
    };
    sddm = {
      enable = false;
      wayland.enable = true;
      theme="sugar-dark";
    };
    ly = {
      enable = true;
      settings = {
#        animate = false;
#        animation = 1;
      };
    };
  };
  # services.fprintd.enable = true; # doesn't detect it (proprietary sensor)

  programs.hyprland.enable = true;

  # Use zsh and oh-my-zsh
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      promptInit = ''
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      '';
      ohMyZsh = {
        enable = true;
        plugins = [ "git colored-man-pages" ];
      };
      shellAliases = {
        cat = "bat -P";
      };
    };
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    noto-fonts
    noto-fonts-emoji
  ] ++ builtins.filter lib.attrsets.isDerivation (
    builtins.attrValues pkgs.nerd-fonts
  );

  services.upower.enable = true;

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
  system.stateVersion = "24.05"; # Did you read the comment?
}
