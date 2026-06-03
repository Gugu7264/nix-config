{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # GUI Apps
    _1password-gui
    signal-desktop
    discord
    slack
    chromium
    # Not really needed anymore (for now, vim >>)
    # vscode
    # jetbrains.idea
    # jetbrains.clion
    # plex-desktop
    # cura-appimage
    imagemagick

    # CLI Tools
    tree
    ripgrep
    fd
    hyperfine
    tldr

    # NOTE: might have been updated to work, check nixpkgs PR
    # (writeShellScriptBin "digikam" ''
    #   QT_QPA_PLATFORM=xcb ${pkgs.digikam}/bin/digikam "$@"
    # '')
  ];

  programs.btop.enable = true;
  programs.bat.enable = true;
}
