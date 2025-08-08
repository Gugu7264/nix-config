{pkgs, ...}: {
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
    firefox
    _1password-gui
    signal-desktop
    whatsapp-for-linux

    dunst # notification manager
    tree # command
    htop # command
    lxqt.lxqt-policykit
    wl-clipboard

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
    unzip
    jupyter
    cmake
    pkg-config
    openssl
    curlFull
    hyperfine
    ripgrep

    # AFS connection
    krb5
    sshfs
    openssh

    # Others
    discord
    slack
    imagemagick
    chromium
    vscode
    jetbrains.idea-ultimate

    toolbox # IDEA Code with me
    plex-desktop

    cura-appimage

    libfido2
    pam_u2f

    (writeShellScriptBin "digikam" ''
      QT_QPA_PLATFORM=xcb ${pkgs.digikam}/bin/digikam "$@"
    '')
  ];

  fonts.packages = with pkgs;
    [
      fira-code
      fira-code-symbols
      font-awesome
      noto-fonts
      noto-fonts-emoji
    ]
    ++ builtins.filter lib.attrsets.isDerivation (
      builtins.attrValues pkgs.nerd-fonts
    );

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

  programs.zsh.enable = true;
  programs.steam.enable = true;

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;
  };
}
