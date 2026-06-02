{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    _1password-gui
    signal-desktop
    discord
    slack
    imagemagick
    chromium
    vscode
    jetbrains.idea
    jetbrains.clion
    plex-desktop
    cura-appimage
    # jupyter
    # (writeShellScriptBin "digikam" ''
    #   QT_QPA_PLATFORM=xcb ${pkgs.digikam}/bin/digikam "$@"
    # '')
  ];
}
