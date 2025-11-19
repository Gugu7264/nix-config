{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    xdg-desktop-portal-wlr # Better portal for maomaowm
    rofi-wayland
    alacritty
    waybar # Status bar
    adwaita-icon-theme # Cursor icons
    hyprshot # screenshots (should work with any Wayland compositor)
    dunst # Notification daemon
    lxqt.lxqt-policykit # Policy kit agent
    wl-clipboard # Clipboard utilities
  ];

  wayland.windowManager.maomaowm = {
    enable = true;
    settings = builtins.readFile ./configs/maomaowm.conf;
    autostart_sh = ''
      # Autostart applications (converted from Hyprland exec-once)
      lxqt-policykit-agent &
      dunst &
      waybar &

      firefox &
      (sleep 1 && discord) &
      (sleep 2 && slack) &

      # Cursor setup (converted from Hyprland)
      hyprctl setcursor Adwaita 24 || true &

      systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots; systemctl --user import-environment WAYLAND_DISPLAY; systemctl --user start xdg-desktop-portal-wlr.service
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
