{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;

    plugins = {
      dcalUpcoming = {
        enable = true;
        src = pkgs.applyPatches {
          name = "dms-dcal";
          src = inputs.dms-dcal;
          patches = [
            ./dcal-scroll-setting.patch
          ];
        };
      };
    };

    settings = {
      currentThemeName = "purple";
      cornerRadius = 16;
      dankLauncherV2Size = "compact";
      closeNiriOverviewOnWindowFocus = true;
      niriOverviewOverlayEnabled = true;
      enableFprint = true;
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 0;
          screenPreferences = [ "all" ];
          showOnLastDisplay = true;
          leftWidgets = [
            "launcherButton"
            "workspaceSwitcher"
            "focusedWindow"
          ];
          centerWidgets = [
            "music"
            "clock"
            "weather"
            "dcalUpcoming"
          ];
          rightWidgets = [
            "systemTray"
            "clipboard"
            "cpuUsage"
            "memUsage"
            "notificationButton"
            "battery"
            "controlCenterButton"
          ];
        }
      ];
    };

    session = {
      isLightMode = true;
      weatherLocation = "Paris, France";
      weatherCoordinates = "48.8566,2.3522";
    };

    niri = {
      enableSpawn = true;
      includes = {
        enable = true;
        override = true;
        filesToInclude = [
          "alttab"
          # "binds" # Managed in niri.nix for seamless integration with custom keybindings
          "colors"
          "layout"
          "outputs"
          "windowrules" # Essential: keeps DMS windows/modals (app-id com.danklinux.dms) floating
          "wpblur" # Blurred overview wallpaper layer
        ];
      };
    };
  };
}
