# Preset for the GL65 Leopard 10SFK laptop: https://www.msi.com/Laptop/GL65-Leopard-10SX/Specification

{ pkgs, ... }:

{
  # -- Config --
  imports = [
    ../gpu/nvidia-hybrid-graphics.nix # Import Nvidia hybrid graphics preset
  ];

  # Configure hybrid graphics
  hardware.nvidia.prime = {
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  networking.interfaces.enp3s0.wakeOnLan.enable = true; # Wake On Lan

  # -- Fixes --
  boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ]; # Fix NVMe SSD timeouts (prevent deep sleep)
  boot.blacklistedKernelModules = [ "ucsi_ccg" ]; # There is no usb-c display port support on the laptop but linux thinks there is
  hardware.nvidia.open = pkgs.lib.mkForce false; # When enabled causes hardware lockups, graphical glitches and silent freezes

  # Disable all sleep and suspend states since it causes many problems with the Nvidia drivers
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
