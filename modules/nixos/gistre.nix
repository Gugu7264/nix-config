{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mosquitto
    # kicad
    node-red
    arduino-ide

    # The following packages are needed to replace STM32CubeIDE by CLion
    gcc-arm-embedded # The cross-compiler
    openocd # The debugging server
    # cmake and gnumake are provided in packages/dev.nix
    # stm32cubemx # The standalone ST configurator

    # INFO8
    # kubectl
    # lens

    # VHDL
    # ghdl-llvm
    # surfer
    # (quartus-prime-lite.override {
    #   supportedDevices = [
    #     "Cyclone V"
    #     "MAX 10 FPGA"
    #   ];
    # })
  ];
}
