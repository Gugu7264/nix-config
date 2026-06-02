{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    btop
    bat
    unzip
    zip
    ripgrep
    fd
    curlFull
    wget
    hyperfine
    tldr
    man-pages
    man-pages-posix
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
  ];
}
