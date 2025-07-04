{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    xdg-desktop-portal-hyprland
    rofi-wayland
    alacritty
    waybar # Status bar
    adwaita-icon-theme # Cursor icons
    hyprshot # screenshots
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [
      (pkgs.callPackage ({
        lib,
        fetchFromGitHub,
        hyprland,
        hyprlandPlugins,
      }:
        hyprlandPlugins.mkHyprlandPlugin pkgs.hyprland {
          pluginName = "hyprWorkspaceLayouts";
          version = "2024-07-04";

          src = fetchFromGitHub {
            owner = "zakk4223";
            repo = "hyprWorkspaceLayouts";
            rev = "main";
            hash = "sha256-1dxRcryNRh0zPiuO5EusPY0Qazh6Ogca41C+/gvs15g=";
          };

          # any nativeBuildInputs required for the plugin
          nativeBuildInputs = [];

          # set any buildInputs that are not already included in Hyprland
          # by default, Hyprland and its dependencies are included
          buildInputs = [];

          meta = {
            homepage = "https://github.com/zakk4223/hyprWorkspaceLayouts";
            description = "Hyprland plugin for workspace layouts";
            license = lib.licenses.mit;
            platforms = lib.platforms.linux;
            maintainers = [];
          };
        }) {})
    ];
  };

  home.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    MOZ_ENABLE_WAYLAND = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  xdg.configFile."hypr/hyprland.conf".source = ./configs/hyprland.conf;
}
