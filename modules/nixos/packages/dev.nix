{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gcc
    gnumake
    valgrind
    gdb
    clang-tools
    cmake
    pkg-config
    python3
  ];
}
