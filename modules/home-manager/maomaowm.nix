{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    xdg-desktop-portal-wlr
    alacritty
    adwaita-icon-theme
    hyprshot
    dunst
    lxqt.lxqt-policykit
    wl-clipboard
  ];

  wayland.windowManager.maomaowm = {
    enable = true;
    settings = builtins.readFile ./configs/maomaowm.conf;
    autostart_sh = ''
      # Autostart applications
      lxqt-policykit-agent &
      dunst &
      waybar &

      firefox &
      (sleep 1 && discord) &
      (sleep 2 && slack) &

      # Cursor setup
      hyprctl setcursor Adwaita 24 || true &

      systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots
      systemctl --user import-environment WAYLAND_DISPLAY

      systemctl --user start xdg-desktop-portal-wlr.service
      systemctl --user restart elephant.service

      walker --gapplication-service &
    '';
  };

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CURRENT_DESKTOP = "wlroots";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "wlroots";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
}
