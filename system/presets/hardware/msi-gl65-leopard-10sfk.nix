# Preset for the GL65 Leopard 10SFK laptop: https://www.msi.com/Laptop/GL65-Leopard-10SX/Specification

{ lib, ... }:

{
  # -- Config --
  imports = [
    ../../../nixos-hardware/msi/gl65/10SDR-492/default.nix # Import from nixos-hardware repository
  ];

  # Nvidia hybrid graphics
  hardware.nvidia.prime = {
    offload.enable = false;
    sync.enable = true;

    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Enable battery saver specialisation from nixos-hardware
  hardware.nvidia.primeBatterySaverSpecialisation = true;
  specialisation."battery-saver".configuration = {
    hardware.nvidia.prime.sync.enable = lib.mkForce false;

    # RE-ENABLE SLEEP & SUSPEND
    systemd.targets.sleep.enable = lib.mkForce true;
    systemd.targets.suspend.enable = lib.mkForce true;
    systemd.targets.hibernate.enable = lib.mkForce true;
    systemd.targets.hybrid-sleep.enable = lib.mkForce true;
  };

  networking.interfaces.enp3s0.wakeOnLan.enable = true; # Wake On Lan

  # -- Fixes --
  boot.kernelParams = [
    "nvme_core.default_ps_max_latency_us=0" # Fix NVMe SSD timeouts (prevent deep sleep)
    "pcie_aspm=off" # Uses more power but testing if this fixes a crash on boot
  ];
  boot.blacklistedKernelModules = [ "ucsi_ccg" ]; # There is no usb-c display port support on the laptop but linux thinks there is

  # Disable all sleep and suspend states since it causes many problems with the Nvidia drivers
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
