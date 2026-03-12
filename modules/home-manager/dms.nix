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
      # Add any other settings here
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
