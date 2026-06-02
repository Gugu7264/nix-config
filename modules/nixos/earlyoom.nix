{ ... }:
{
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 5;
    extraArgs = [
      "-g"
      "--prefer"
      "'^(.*/)?(java|node|clion|electron)$'"
      "--avoid"
      "'^(.*/)?(sshd|systemd|X|wayland|niri)$'"
    ];
  };
}
