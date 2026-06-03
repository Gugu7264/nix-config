{ pkgs, ... }:
{
  security.pam = {
    services = {
      sudo.u2fAuth = true;
      login.u2fAuth = true;
      hyprlock = {
        text = ''
          auth       sufficient     pam_unix.so try_first_pass likeauth nullok
          auth       sufficient     pam_fprintd.so
          auth       include        system-auth

          account    include        system-auth
          password   include        system-auth
          session    include        system-auth
        '';
      };
    };
    u2f.settings.cue = true;
  };

  services.fprintd.enable = true;
}
