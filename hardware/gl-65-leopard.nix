# Options specific to the GL 65 Leopard laptop

{ pkgs, ... }:

{
  # Config
  networking.interfaces.enp3s0.wakeOnLan.enable = true; # Wake On Lan

  # Mandatory Fixes
  boot.blacklistedKernelModules = [ "ucsi_ccg" ]; # There is no usb-c display port support on the laptop but linux thinks there is which causes crashes and hangs
  hardware.nvidia.open = pkgs.lib.mkForce false; # When enabled causes hardware lockups, graphical glitches and silent freezes
}
