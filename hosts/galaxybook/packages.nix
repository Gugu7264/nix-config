{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    alacritty # Terminal emulator
    rofi-wayland # Application chooser
    firefox
    _1password-gui
    signal-desktop
    whatsapp-for-linux

    dunst # notification manager
    tree # command
    htop # command
    lxqt.lxqt-policykit
    wl-clipboard

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
    unzip
    jupyter
    cmake
    pkg-config
    openssl
    curlFull
    hyperfine

    # AFS connection
    krb5
    sshfs
    openssh_gssapi

    # Others
    discord
    imagemagick
    chromium
    vscode
    hyprshot # screenshots
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
}
