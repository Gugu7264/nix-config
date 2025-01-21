{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.abelc.cava;
in 
  {
  options.abelc.cava = { enable = mkEnableOption "cava"; };
  config = mkIf cfg.enable {
    programs.cava = {
      enable = false;
      settings = {
        general.framerate = 60;
        input.method = "alsa";
        smoothing.noise_reduction = 88;
        color = {
          background = "'#24273a'";

          gradient = 1;

          gradient_color_1 = "'#8bd5ca'";
          gradient_color_2 = "'#91d7e3'";
          gradient_color_3 = "'#7dc4e4'";
          gradient_color_4 = "'#8aadf4'";
          gradient_color_5 = "'#c6a0f6'";
          gradient_color_6 = "'#f5bde6'";
          gradient_color_7 = "'#ee99a0'";
          gradient_color_8 = "'#ed8796'";
        };
      };
    };
    home.packages = [ pkgs.cava ];
  };
}
