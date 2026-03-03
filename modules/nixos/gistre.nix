{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    mosquitto
    kicad
    node-red
    arduino-ide

    # The following 4 packages are needed to replace STM32CubeIDE by CLion
    gcc-arm-embedded # The cross-compiler
    openocd # The debugging server
    cmake # Build system (used by CLion)
    gnumake # Make (used by CMake)
    stm32cubemx # The standalone ST configurator
  ];
}
