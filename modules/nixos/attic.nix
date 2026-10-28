{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [ attic-client ];
  nix = {
    settings = {
      substituters = [
        "http://10.201.3.150:8000/yaka-cache"
        "https://nix-community.cachix.org"
        "https://cache.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "yaka-cache:sRTS8g4S0vP5WzVW4kIJ1C+PR9y2AS+2WpC3G2gXB7g="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      # Build from source if the binary cache is unreachable
      fallback = true;

      # Give up connecting to the cache after 3 seconds (default is 15)
      connect-timeout = 5;

      # Only try to download once (default is 5)
      download-attempts = 2;
    };
  };
}
