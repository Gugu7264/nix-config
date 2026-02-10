_: {
  programs.hyprlock = {
    enable = true;
    settings = {
      auth = {
        "fingerprint:enabled" = true;
        # Optional: Customize the messages
        "fingerprint:ready_message" = "(Scan Fingerprint)";
        "fingerprint:present_message" = "Scanning...";
      };
      general = {
        disable_loading = true;
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          monitor = "";
          path = "screenshot"; # This takes a blurred screenshot of your current desktop
          color = "rgba(25, 20, 20, 1.0)";
          blur_passes = 2;
          blur_size = 7;
          noise = 0.0117;
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "250, 60";
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.5)";
          font_color = "rgb(200, 200, 200)";
          fade_on_empty = false;
          placeholder_text = "<i>$USER</i>";
          hide_input = false;
          position = "0, -20";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Clock
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 64;
          font_family = "Sans";
          position = "-100, 70";
          halign = "right";
          valign = "bottom";
        }
        # Fingerprint Status Message
        {
          monitor = "";
          text = "cmd[update:500] echo \"$FPRINTMESSAGE\"";
          color = "rgba(200, 200, 200, 1.0)";
          font_size = 14;
          font_family = "Sans";
          position = "0, -100";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
