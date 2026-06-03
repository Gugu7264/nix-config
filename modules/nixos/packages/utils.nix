{ pkgs, ... }:
{
  # Only tools that are useful system-wide or for multiple users
  environment.systemPackages = with pkgs; [
    brightnessctl
    libnotify
    wl-clipboard
    pavucontrol
    pamixer
    rclone
    toolbox
    lan-mouse
    libei
    yubikey-manager
    unzip
    zip
    curlFull
    wget
    man-pages
    man-pages-posix
  ];
}
