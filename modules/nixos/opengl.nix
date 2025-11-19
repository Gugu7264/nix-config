{ config, pkgs, lib, ... }:
{
  hardware.graphics.enable = true;
  # hardware.opengl.enable = true; # Deprecated in recent NixOS, graphics.enable covers it usually, but let's keep what user had if needed or stick to new standard. User had both.
  # In 24.11 hardware.opengl is renamed to hardware.graphics.
  # I will use hardware.graphics as it is the new standard.
}
