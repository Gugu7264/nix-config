_: {
  services.kanshi = {
    enable = true;
    settings = [
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1"; # Your laptop screen name
            status = "enable";
            scale = 1.0; # Adjust scale as needed
          }
        ];
      }
      {
        profile.name = "docked-desk";
        profile.outputs = [
          {
            criteria = "eDP-1";
            position = "0,0";
            mode = "1920x1080";
          }
          {
            # Replace 'HDMI-A-1' with your external monitor name
            criteria = "HDMI-A-1";
            position = "0,1080"; # Places it to the right of laptop
            mode = "1920x1080";
            scale = 1.0;
          }
        ];
      }
    ];
  };
}
