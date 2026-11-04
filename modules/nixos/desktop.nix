{ inputs, pkgs, ... }:
{
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
      inputs.dux-files.packages.${pkgs.stdenv.hostPlatform.system}.dux-files
    ];
    config = {
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [
          "dfiles"
          "gtk"
        ];
      };
      common.default = "*";
    };
  };

  services.dbus.enable = true;

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    font-awesome
    noto-fonts
    noto-fonts-color-emoji
    nerd-fonts.symbols-only
    cascadia-code
  ];
}
