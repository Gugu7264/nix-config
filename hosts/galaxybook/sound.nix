{pkgs, ...}: let
  rnnoise_config = {
    "context.modules" = [
      {
        "name" = "libpipewire-module-filter-chain";
        "args" = {
          "node.description" = "Noise Canceling source";
          "media.name" = "Noise Canceling source";
          "filter.graph" = {
            "nodes" = [
              {
                "type" = "ladspa";
                "name" = "rnnoise";
                "plugin" = "${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so";
                "label" = "noise_suppressor_stereo";
                "control" = {
                  "VAD Threshold (%)" = 50.0;
                };
              }
            ];
          };
          "audio.position" = ["FL" "FR"];
          "capture.props" = {
            "node.name" = "effect_input.rnnoise";
            "node.passive" = true;
          };
          "playback.props" = {
            "node.name" = "effect_output.rnnoise";
            "media.class" = "Audio/Source";
          };
        };
      }
    ];
  };
in {
  boot.extraModprobeConfig = ''
    options snd_hda_intel model=laptop-dmic
  '';

  security.rtkit.enable = true; # Recommended for sound
  hardware.enableRedistributableFirmware = true; # Same, enableAllFirmware didn't seem useful

  services.pipewire = {
    enable = true; # Default is true on nixos, but sound doesn't work out of the box
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig = {
      pipewire."99-input-denoising" = rnnoise_config;
      pipewire = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.alloed-rates" = [48000 96000];
          "default.clock.quantum" = 32;
          "default.clock.min-quantum" = 32;
          "default.clock.max-quantum" = 64;
        };
      };
      pipewire-pulse = {
        "stream.properties" = {
          "resample.quality" = 10;
        };
      };
    };
  };
}
