# Preset for the GL65 Leopard laptop: https://www.msi.com/Laptop/GL65-Leopard-10SX/Specification
# Tested on: GL65 Leopard 10SFK-206CA

{ lib, ... }:

{
  # -- Config --
  imports = [
    ../../../nixos-hardware/msi/gl65/default.nix # Import from nixos-hardware repository
  ];

  # Make everything run on the gpu by default
  hardware.nvidia.prime = {
    offload.enable = false;
    sync.enable = true;
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

  # SSD fixes (probably not a laptop problem but keeping it here anyways)
  boot.kernelParams = [
    "nvme_core.default_ps_max_latency_us=0" # Fix NVMe SSD timeouts (prevent deep sleep)
    "pcie_aspm=off" # Uses more power but testing if this fixes a crash on boot
  ];
  
  # Disable all sleep and suspend states since it causes many problems with the Nvidia drivers
  systemd.targets.sleep.enable = false;
  systemd.targets.suspend.enable = false;
  systemd.targets.hibernate.enable = false;
  systemd.targets.hybrid-sleep.enable = false;
}
