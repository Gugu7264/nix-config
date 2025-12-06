{pkgs, ...}: let
  micLedWatcher = pkgs.writeShellApplication {
    name = "mic-led-watcher";

    runtimeInputs = with pkgs; [
      wireplumber
      pulseaudio
      gnugrep
      coreutils
    ];

    text = ''
      LED_PATH="/sys/class/leds/platform::micmute/brightness"

      update_led() {
        if wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -qi "muted"; then
          echo 1 > "$LED_PATH"
        else
          echo 0 > "$LED_PATH"
        fi
      }

      update_led

      pactl subscribe | grep --line-buffered "source" | while read -r _; do
        update_led
      done
    '';
  };
in {
  services.udev.extraRules = ''
    SUBSYSTEM=="leds", KERNEL=="platform::micmute", MODE="0666"
  '';

  systemd.user.services.mic-led-watcher = {
    description = "ThinkPad Mic Mute LED Watcher";

    wantedBy = ["default.target"];
    after = [
      "pipewire.service"
      "wireplumber.service"
      "pipewire-pulse.service"
    ];

    serviceConfig = {
      ExecStart = "${micLedWatcher}/bin/mic-led-watcher";
      Restart = "always";
      RestartSec = "3";
    };
  };
}
