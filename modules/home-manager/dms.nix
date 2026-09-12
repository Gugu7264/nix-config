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
      currentThemeName = "purple";
      cornerRadius = 16;
      dankLauncherV2Size = "compact";
      closeNiriOverviewOnWindowFocus = true;
      niriOverviewOverlayEnabled = true;
    };

    session = {
      isLightMode = true;
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
