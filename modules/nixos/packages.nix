{
  config,
  pkgs,
  lib,
  ...
}:
{
  nixpkgs.overlays = [
    (final: prev: {
      sshfs = prev.sshfs.override {
        callPackage = prev.newScope {
          openssh = pkgs.openssh_gssapi;
        };
      };
    })
  ];

  programs.ssh.package = pkgs.openssh_gssapi;

  environment.systemPackages = with pkgs; [
    _1password-gui
    signal-desktop
    # wasistlos
    tree
    btop
    lxqt.lxqt-policykit
    wl-clipboard
    pavucontrol
    pamixer
    libnotify
    bat
    git
    gcc
    gnumake
    valgrind
    gdb
    clang-tools
    man-pages
    man-pages-posix
    tldr
    pre-commit
    unzip
    jupyter
    cmake
    pkg-config
    openssl
    curlFull
    hyperfine
    ripgrep
    krb5
    sshfs
    openssh
    discord
    slack
    imagemagick
    chromium
    vscode
    jetbrains.idea
    jetbrains.clion
    toolbox
    plex-desktop
    cura-appimage
    libfido2
    pam_u2f
    # NOTE: might have been updated to work, check nixpkgs PR
    # (writeShellScriptBin "digikam" ''
    #   QT_QPA_PLATFORM=xcb ${pkgs.digikam}/bin/digikam "$@"
    # '')
    rclone
    php
    yubikey-manager
    gnupg
    nh
    brightnessctl

    lan-mouse # use keyboard and mouse on other devices
    libei
  ];

  fonts.packages =
    with pkgs;
    [
      fira-code
      fira-code-symbols
      font-awesome
      noto-fonts
      noto-fonts-color-emoji
    ]
    ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
}
