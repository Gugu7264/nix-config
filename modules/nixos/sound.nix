_:
{
  security.rtkit.enable = true;
  hardware.enableRedistributableFirmware = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    extraConfig = {
      # pipewire."99-input-denoising" = rnnoise_config;
      pipewire = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.allowed-rates" = [
            48000
            96000
          ];
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
