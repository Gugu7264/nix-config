_: {
  services.mako = {
    enable = true;
    settings = {
      width = 400;
      font = "Cascadia Code 12, Symbols Nerd Font 12";

      background-color = "#24273a";
      text-color = "#cad3f5";
      border-color = "#7dc4e4";
      progress-color = "over #363a4f";

      padding = 10;
      border-radius = 10;
      border-size = 3;
      default-timeout = 10000;

      "urgency=high" = {
        border-color = "#f5a97f";
      };

      "mode=do-not-disturb" = {
        invisible = 1;
        on-notify = "none";
      };
    };
  };
}
