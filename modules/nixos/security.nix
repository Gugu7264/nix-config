_: {
  security.polkit.enable = true;

  security.pam = {
    services = {
      sudo = {
        u2fAuth = true;
        fprintAuth = true;
      };
      login.u2fAuth = true;
      polkit-1.u2fAuth = true;
      dankshell = {
        u2fAuth = true;
        fprintAuth = true;
      };
    };
    u2f.settings.cue = true;
  };

  services.fprintd.enable = true;
}
