{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nautilus
    xwayland-satellite
    adwaita-icon-theme
    wdisplays # for quick moving screens
    wl-mirror # for mirroring to another screen
  ];

  programs.niri = {
    settings = {
      environment = {
        DMS_DISABLE_MATUGEN = "1";
      };

      cursor = {
        theme = "Adwaita";
        size = 24;
      };

      prefer-no-csd = true;

      hotkey-overlay = {
        skip-at-startup = true;
      };

      spawn-at-startup = [
        {
          argv = [
            "dbus-update-activation-environment"
            "--systemd"
            "WAYLAND_DISPLAY"
            "XDG_CURRENT_DESKTOP"
          ];
        }
        { argv = [ "slack" ]; }
        { argv = [ "discord" ]; }
        { argv = [ "zen" ]; }
      ];

      workspaces = {
        "chat" = { };
        "ws-1" = { };
        "ws-2" = { };
        "ws-3" = { };
        "ws-4" = { };
      };

      outputs = {
        "eDP-1" = {
          scale = 1.0;
          position = {
            x = 0;
            y = 1080;
          };
          variable-refresh-rate = "on-demand";
        };
        "HDMI-A-1" = {
          scale = 1.0;
          mode = {
            width = 1920;
            height = 1080;
            refresh = 100.0;
          };
          position = {
            x = 0;
            y = 0;
          };
          variable-refresh-rate = "on-demand";
        };
      };

      input = {
        keyboard = {
          xkb.layout = "fr";
          repeat-delay = 600;
          repeat-rate = 25;
        };
        touchpad = {
          tap = true;
          natural-scroll = false;
          dwt = true;
        };
        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "0%";
        };
        warp-mouse-to-focus = {
          enable = true;
          mode = "center-xy";
        };
        workspace-auto-back-and-forth = false;
      };

      layout = {
        gaps = 16;
        empty-workspace-above-first = false;
        default-column-display = "normal";

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.0; }
        ];

        default-column-width = {
          proportion = 0.5;
        };

        preset-window-heights = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
          { proportion = 1.0; }
        ];

        focus-ring = {
          enable = true;
          width = 2.0;
        };

        border = {
          enable = false;
        };

        shadow = {
          enable = true;
          softness = 30.0;
          spread = 4.0;
          offset = {
            x = 0.0;
            y = 4.0;
          };
          color = "#00000060";
        };

        tab-indicator = {
          enable = true;
          hide-when-single-tab = true;
          place-within-column = true;
          gap = 4.0;
          width = 4.0;
          position = "left";
          corner-radius = 8.0;
        };
      };

      overview = {
        zoom = 0.5;
        backdrop-color = "#181825";
      };

      recent-windows = {
        enable = true;
        debounce-ms = 750;
        open-delay-ms = 150;
        highlight = {
          corner-radius = 12;
        };
        previews = {
          max-height = 480;
          max-scale = 0.5;
        };
      };

      window-rules = [
        # Chat applications on designated workspace
        {
          matches = [
            { app-id = "discord"; }
            { app-id = "Slack"; }
            { app-id = "signal"; }
          ];
          default-column-width = {
            proportion = 0.95;
          };
          open-on-workspace = "chat";
          open-focused = false;
        }
        # Zen Browser at startup
        {
          matches = [
            {
              app-id = "zen";
              at-startup = true;
            }
          ];
          default-column-width = {
            proportion = 1.0;
          };
          open-on-workspace = "ws-1";
          open-focused = false;
        }
        # Privacy: Protect passwords and secrets from screencasts
        {
          matches = [
            { app-id = "1Password"; }
            { app-id = "keepassxc"; }
            { app-id = "org.keepassxc.KeePassXC"; }
          ];
          block-out-from = "screencast";
        }
        # Common utility dialogs open floating
        {
          matches = [
            { app-id = "pavucontrol"; }
            { app-id = "nm-connection-editor"; }
            { app-id = "blueman-manager"; }
            { app-id = "wdisplays"; }
            { app-id = "com.danklinux.dankcalendar"; }
            { title = "^Picture-in-Picture$"; }
            { title = "^Open File$"; }
            { title = "^Save File$"; }
          ];
          open-floating = true;
        }
      ];

      binds = with config.lib.niri.actions; {
        # === System & Session ===
        "Mod+Shift+colon" = {
          action = show-hotkey-overlay;
          hotkey-overlay.title = "Show Hotkey Overlay / Cheat Sheet";
        };
        "Mod+F1".action = show-hotkey-overlay;
        "Mod+Escape" = {
          action = toggle-keyboard-shortcuts-inhibit;
          hotkey-overlay.title = "Toggle Shortcut Inhibitor";
        };
        "Mod+Shift+E" = {
          action = quit;
          hotkey-overlay.title = "Quit Niri";
        };
        "Mod+Ctrl+Shift+E" = {
          action = quit { skip-confirmation = true; };
          hotkey-overlay.title = "Force Quit Niri";
        };
        "Mod+L" = {
          action = spawn "dms" "ipc" "call" "lock" "lock";
          hotkey-overlay.title = "Lock Screen (DMS)";
        };
        "Super+X" = {
          action = spawn "dms" "ipc" "call" "powermenu" "toggle";
          hotkey-overlay.title = "DMS Power Menu";
        };

        # === Overview & Application Launchers ===
        "Mod+O" = {
          action = toggle-overview;
          hotkey-overlay.title = "Toggle Overview";
        };
        "Mod+Return" = {
          action = spawn "alacritty";
          hotkey-overlay.title = "Open Terminal";
        };
        "Mod+D" = {
          action = spawn "walker";
          hotkey-overlay.title = "Application Launcher (Walker)";
        };
        "Mod+Space" = {
          action = spawn "dms" "ipc" "call" "spotlight" "toggle";
          hotkey-overlay.title = "DMS Spotlight Launcher";
        };
        "Mod+V" = {
          action = spawn "dms" "ipc" "call" "clipboard" "toggle";
          hotkey-overlay.title = "DMS Clipboard History";
        };
        "Mod+N" = {
          action = spawn "dms" "ipc" "call" "notifications" "toggle";
          hotkey-overlay.title = "DMS Notification Center";
        };
        "Mod+Shift+N" = {
          action = spawn "dms" "ipc" "call" "notepad" "toggle";
          hotkey-overlay.title = "DMS Notepad Slideout";
        };
        "Mod+Shift+Comma" = {
          action = spawn "dms" "ipc" "call" "settings" "focusOrToggle";
          hotkey-overlay.title = "DMS Settings";
        };
        "Ctrl+Shift+Escape" = {
          action = spawn "dms" "ipc" "call" "processlist" "focusOrToggle";
          hotkey-overlay.title = "Task Manager / Process List";
        };
        "Mod+Alt+N" = {
          action = spawn "dms" "ipc" "call" "night" "toggle";
          hotkey-overlay.title = "Toggle Night Mode";
        };
        "Mod+Alt+T" = {
          action = spawn "dms" "ipc" "call" "theme" "toggle";
          hotkey-overlay.title = "Toggle Dark/Light Theme";
        };
        "Mod+Y" = {
          action = spawn "dms" "ipc" "call" "dash" "toggle" "wallpaper";
          hotkey-overlay.title = "DMS Wallpaper Browser";
        };
        "Mod+Shift+W" = {
          action = spawn "dms" "ipc" "call" "window-rules" "toggle";
          hotkey-overlay.title = "DMS Window Rule Helper";
        };
        "Alt+Space" = {
          action = spawn "dms" "ipc" "call" "spotlight-bar" "toggle";
          hotkey-overlay.title = "DMS Spotlight Bar";
        };

        # === Window & Column Management ===
        "Mod+Shift+Q" = {
          action = close-window;
          hotkey-overlay.title = "Close Window";
        };
        "Mod+F" = {
          action = fullscreen-window;
          hotkey-overlay.title = "Fullscreen Window";
        };
        "Mod+M" = {
          action = maximize-column;
          hotkey-overlay.title = "Maximize Column";
        };
        "Mod+E" = {
          action = expand-column-to-available-width;
          hotkey-overlay.title = "Expand Column to Available Width";
        };
        "Mod+C" = {
          action = center-column;
          hotkey-overlay.title = "Center Focused Column";
        };
        "Mod+W" = {
          action = toggle-column-tabbed-display;
          hotkey-overlay.title = "Toggle Column Tabbed Display";
        };
        "Mod+Shift+Space" = {
          action = toggle-window-floating;
          hotkey-overlay.title = "Toggle Window Floating";
        };
        "Mod+Alt+Space" = {
          action = switch-focus-between-floating-and-tiling;
          hotkey-overlay.title = "Switch Focus Floating / Tiling";
        };
        "Mod+R" = {
          action = switch-preset-column-width;
          hotkey-overlay.title = "Cycle Column Width Preset";
        };
        "Mod+Shift+R" = {
          action = switch-preset-column-width-back;
          hotkey-overlay.title = "Cycle Column Width Preset Backwards";
        };
        "Mod+equal" = {
          action = set-column-width "-10%";
          hotkey-overlay.title = "Shrink Column Width";
        };
        "Mod+Shift+equal" = {
          action = set-column-width "+10%";
          hotkey-overlay.title = "Grow Column Width";
        };
        "Mod+comma" = {
          action = consume-or-expel-window-right;
          hotkey-overlay.title = "Consume or Expel Window Right";
        };
        "Mod+Shift+C" = {
          action = consume-window-into-column;
          hotkey-overlay.title = "Consume Window into Column";
        };
        "Mod+Shift+X" = {
          action = expel-window-from-column;
          hotkey-overlay.title = "Expel Window from Column";
        };

        # === Navigation & Movement ===
        "Mod+Left" = {
          action = focus-column-left;
          hotkey-overlay.title = "Focus Column Left";
        };
        "Mod+Right" = {
          action = focus-column-right;
          hotkey-overlay.title = "Focus Column Right";
        };
        "Mod+Shift+Left" = {
          action = move-column-left;
          hotkey-overlay.title = "Move Column Left";
        };
        "Mod+Shift+Right" = {
          action = move-column-right;
          hotkey-overlay.title = "Move Column Right";
        };
        "Mod+Down" = {
          action = focus-workspace-down;
          hotkey-overlay.title = "Focus Workspace Down";
        };
        "Mod+Up" = {
          action = focus-workspace-up;
          hotkey-overlay.title = "Focus Workspace Up";
        };
        "Mod+Shift+Down" = {
          action = move-column-to-workspace-down;
          hotkey-overlay.title = "Move Column to Workspace Below";
        };
        "Mod+Shift+Up" = {
          action = move-column-to-workspace-up;
          hotkey-overlay.title = "Move Column to Workspace Above";
        };
        "Mod+Alt+Down" = {
          action = focus-window-down;
          hotkey-overlay.title = "Focus Window Down in Column";
        };
        "Mod+Alt+Up" = {
          action = focus-window-up;
          hotkey-overlay.title = "Focus Window Up in Column";
        };
        "Mod+Alt+Shift+Down" = {
          action = move-window-down;
          hotkey-overlay.title = "Move Window Down in Column";
        };
        "Mod+Alt+Shift+Up" = {
          action = move-window-up;
          hotkey-overlay.title = "Move Window Up in Column";
        };
        "Mod+Tab" = {
          action = focus-column-right-or-first;
          hotkey-overlay.title = "Focus Next Column";
        };
        "Mod+Shift+Tab" = {
          action = focus-column-left-or-last;
          hotkey-overlay.title = "Focus Previous Column";
        };

        # === Multi-Monitor Navigation ===
        "Mod+Ctrl+Right" = {
          action = focus-monitor-right;
          hotkey-overlay.title = "Focus Monitor Right";
        };
        "Mod+Ctrl+Left" = {
          action = focus-monitor-left;
          hotkey-overlay.title = "Focus Monitor Left";
        };
        "Mod+Ctrl+Up" = {
          action = focus-monitor-up;
          hotkey-overlay.title = "Focus Monitor Up";
        };
        "Mod+Ctrl+Down" = {
          action = focus-monitor-down;
          hotkey-overlay.title = "Focus Monitor Down";
        };
        "Mod+Ctrl+Shift+Right" = {
          action = move-column-to-monitor-right;
          hotkey-overlay.title = "Move Column to Monitor Right";
        };
        "Mod+Ctrl+Shift+Left" = {
          action = move-column-to-monitor-left;
          hotkey-overlay.title = "Move Column to Monitor Left";
        };
        "Mod+Ctrl+Shift+Up" = {
          action = move-column-to-monitor-up;
          hotkey-overlay.title = "Move Column to Monitor Up";
        };
        "Mod+Ctrl+Shift+Down" = {
          action = move-column-to-monitor-down;
          hotkey-overlay.title = "Move Column to Monitor Down";
        };

        # === Named Workspaces (AZERTY French Layout) ===
        "Mod+twosuperior" = {
          action = focus-workspace "chat";
          hotkey-overlay.title = "Focus Chat Workspace";
        };
        "Mod+Shift+twosuperior" = {
          action.move-window-to-workspace = "chat";
          hotkey-overlay.title = "Move Window to Chat Workspace";
        };
        "Mod+ampersand" = {
          action = focus-workspace "ws-1";
          hotkey-overlay.title = "Focus Workspace 1";
        };
        "Mod+Shift+ampersand" = {
          action.move-window-to-workspace = "ws-1";
          hotkey-overlay.title = "Move Window to Workspace 1";
        };
        "Mod+eacute" = {
          action = focus-workspace "ws-2";
          hotkey-overlay.title = "Focus Workspace 2";
        };
        "Mod+Shift+eacute" = {
          action.move-window-to-workspace = "ws-2";
          hotkey-overlay.title = "Move Window to Workspace 2";
        };
        "Mod+quotedbl" = {
          action = focus-workspace "ws-3";
          hotkey-overlay.title = "Focus Workspace 3";
        };
        "Mod+Shift+quotedbl" = {
          action.move-window-to-workspace = "ws-3";
          hotkey-overlay.title = "Move Window to Workspace 3";
        };
        "Mod+apostrophe" = {
          action = focus-workspace "ws-4";
          hotkey-overlay.title = "Focus Workspace 4";
        };
        "Mod+Shift+apostrophe" = {
          action.move-window-to-workspace = "ws-4";
          hotkey-overlay.title = "Move Window to Workspace 4";
        };

        # === Screenshots ===
        "Print" = {
          action.screenshot = {
            show-pointer = false;
          };
          hotkey-overlay.title = "Interactive Screenshot";
        };
        "Shift+Print" = {
          action.screenshot-screen = {
            write-to-disk = true;
          };
          hotkey-overlay.title = "Screenshot Screen to Disk";
        };
        "Ctrl+Print" = {
          action.screenshot-window = {
            write-to-disk = true;
          };
          hotkey-overlay.title = "Screenshot Window to Disk";
        };

        # === Hardware Audio & Brightness Controls (DMS OSD) ===
        "XF86AudioRaiseVolume" = {
          action = spawn "dms" "ipc" "call" "audio" "increment" "5";
          allow-when-locked = true;
        };
        "XF86AudioLowerVolume" = {
          action = spawn "dms" "ipc" "call" "audio" "decrement" "5";
          allow-when-locked = true;
        };
        "XF86AudioMute" = {
          action = spawn "dms" "ipc" "call" "audio" "mute";
          allow-when-locked = true;
        };
        "XF86AudioMicMute" = {
          action = spawn "dms" "ipc" "call" "audio" "micmute";
          allow-when-locked = true;
        };
        "XF86MonBrightnessDown" = {
          action = spawn "dms" "ipc" "call" "brightness" "decrement" "5" "";
          allow-when-locked = true;
        };
        "XF86MonBrightnessUp" = {
          action = spawn "dms" "ipc" "call" "brightness" "increment" "5" "";
          allow-when-locked = true;
        };
      };
    };
  };
}
