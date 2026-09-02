{
  inputs,
  ...
}:
{
  imports = [
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;

    settings = {
      theme = "light";
      dynamicTheming = false;
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
          spacing = 4;
          innerPadding = 4;
          maximizeDetection = false;
        }
      ];
    };

    session = {
      isLightMode = true;
      # Add any other session state settings here
    };

    niri = {
      enableSpawn = true;
      includes = {
        enable = true;

        override = true;

        filesToInclude = [
          "alttab"
          # "binds"
          "colors"
          "layout"
          "outputs"
          # "wpblur"
        ];
      };
    };
  };
}
