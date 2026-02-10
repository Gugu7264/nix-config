{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nautilus
    xwayland-satellite
    adwaita-icon-theme
    wdisplays # for quick moving screens
    wl-mirror # for mirroring to another screen
  ];

  programs.niri = {
    settings = {
      workspaces = {
        "chat" = {};
        "ws-1" = {};
        "ws-2" = {};
        "ws-3" = {};
        "ws-4" = {};
      };
      window-rules = [
        {
          matches = [
            {app-id = "discord";}
            {app-id = "Slack";}
          ];
          default-column-width = {proportion = 0.95;};
          open-on-workspace = "chat";
          open-focused = false;
        }
        {
          matches = [
            {
              app-id = "firefox";
              at-startup = true;
            }
          ];
          default-column-width = {proportion = 1.0;};
          open-on-workspace = "1";
          open-focused = false;
        }
      ];
      cursor = {
        theme = "Adwaita";
        size = 16;
      };
      prefer-no-csd = true;
      spawn-at-startup = [
        {
          command = [
            "dbus-update-activation-environment"
            "--systemd"
            "WAYLAND_DISPLAY"
            "XDG_CURRENT_DESKTOP"
          ];
        }
        # {argv = ["kanshi"];}
        {argv = ["waybar"];}
        {argv = ["slack"];}
        {argv = ["discord"];}
        {argv = ["firefox"];}
      ];
      input = {
        keyboard = {
          xkb.layout = "fr";
        };
        focus-follows-mouse.enable = true;
        touchpad.natural-scroll = false;
      };
      outputs = {
        "eDP-1" = {
          scale = 1;
          position = {
            x = 0;
            y = 1080;
          };
        };
        "Iiyama North America PL2493H 11648B8900108" = {
          scale = 1;
          position = {
            x = 0;
            y = 0;
          };
        };
      };
      layout = {
        preset-column-widths = [
          {proportion = 0.33;}
          {proportion = 0.5;}
          {proportion = 1.0;}
        ];
      };

      binds = with config.lib.niri.actions; {
        "XF86AudioRaiseVolume" = {
          action = spawn "wpctl" "set-volume" "-l" "1.0" "@DEFAULT_AUDIO_SINK@" "0.1+";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown".action = spawn-sh "/run/current-system/sw/bin/light -U 5";
        "XF86MonBrightnessUp".action = spawn-sh "/run/current-system/sw/bin/light -A 5";
        "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        "Mod+Shift+E".action = quit;
        "Mod+Ctrl+Shift+E".action = quit {skip-confirmation = true;};

        "Mod+Return".action = spawn "alacritty";
        "Mod+equal".action = set-column-width "-10%";
        "Mod+Shift+equal".action = set-column-width "+10%";
        "Mod+D".action = spawn "walker";
        "Mod+Shift+Tab".action = focus-column-left-or-last;
        "Mod+Tab".action = focus-column-right-or-first;

        "Mod+twosuperior".action = focus-workspace "chat";
        "Mod+Shift+twosuperior".action.move-window-to-workspace = "chat";
        "Mod+ampersand".action = focus-workspace "ws-1";
        "Mod+Shift+ampersand".action.move-window-to-workspace = "ws-1";
        "Mod+eacute".action = focus-workspace "ws-2";
        "Mod+Shift+eacute".action.move-window-to-workspace = "ws-2";
        "Mod+quotedbl".action = focus-workspace "ws-3";
        "Mod+Shift+quotedbl".action.move-window-to-workspace = "ws-3";
        "Mod+apostrophe".action = focus-workspace "ws-4";
        "Mod+Shift+apostrophe".action.move-window-to-workspace = "ws-4";
        "Mod+comma".action = consume-or-expel-window-right;
        "Mod+L".action = spawn "hyprlock";

        "Mod+Left".action = focus-column-left;
        "Mod+Right".action = focus-column-right;
        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Right".action = move-column-right;
        "Mod+Down".action = focus-workspace-down;
        "Mod+Up".action = focus-workspace-up;

        "Mod+F".action = fullscreen-window;
        "Mod+Shift+Q".action = close-window;

        "Print".action.screenshot = {show-pointer = false;};
        "Shift+Print".action.screenshot-screen = {write-to-disk = true;};
        "Ctrl+Print".action.screenshot-window = {write-to-disk = true;};

        "Mod+R".action = switch-preset-column-width;

        "Mod+Ctrl+Right".action = focus-monitor-right;
        "Mod+Ctrl+Left".action = focus-monitor-left;
        "Mod+Ctrl+Up".action = focus-monitor-up;
        "Mod+Ctrl+Down".action = focus-monitor-down;

        "Mod+Ctrl+Shift+Right".action = move-column-to-monitor-right;
        "Mod+Ctrl+Shift+Left".action = move-column-to-monitor-left;
        "Mod+Ctrl+Shift+Up".action = move-column-to-monitor-up;
        "Mod+Ctrl+Shift+Down".action = move-column-to-monitor-down;
      };
    };
  };
}
