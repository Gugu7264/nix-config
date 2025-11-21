{
  config,
  pkgs,
  lib,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      openssh = prev.openssh.overrideAttrs (
        old: {
          configureFlags = old.configureFlags ++ ["--with-kerberos5"];
          buildInputs = old.buildInputs ++ [prev.krb5];
        }
      );
    })
  ];

  environment.systemPackages = with pkgs; [
    _1password-gui
    signal-desktop
    wasistlos
    dunst
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
    jetbrains.idea-ultimate
    jetbrains.phpstorm
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
    jetbrains.datagrip
    yubikey-manager
    gnupg
    # pinentry
  ];

  fonts.packages = with pkgs;
    [
      fira-code
      fira-code-symbols
      font-awesome
      noto-fonts
      noto-fonts-color-emoji
    ]
    ++ builtins.filter lib.attrsets.isDerivation (
      builtins.attrValues pkgs.nerd-fonts
    );
}
