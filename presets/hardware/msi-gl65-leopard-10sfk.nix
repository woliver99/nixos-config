# Preset for the GL65 Leopard laptop: https://www.msi.com/Laptop/GL65-Leopard-10SX/Specification
# Tested on: GL65 Leopard 10SFK-206CA

{ lib, config, pkgs, ... }:

{
  # -- Config --
  imports = [
    ../../nixos-hardware/msi/gl65 # Import from nixos-hardware repository
  ];

  hardware.graphics = { # (Note: use 'hardware.opengl' if on NixOS < 24.05)
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libvdpau-va-gl
    ];
  };

  # Make everything run on the gpu by default
  hardware.nvidia.prime = {
    offload.enable = false;
    sync.enable = true;
  };

  # --CONDITIONAL VARIABLES --
  # These will ONLY exist when Sync mode is enabled.
  # When you switch to "battery-saver" (where sync is false), these vanish automatically.
  environment.sessionVariables = lib.mkIf config.hardware.nvidia.prime.sync.enable {
    # 3D Rendering (Vulkan/OpenGL)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json";

    # Video Decoding (Force apps to use the Nvidia drivers)
    LIBVA_DRIVER_NAME = "nvidia";   # Tells apps "Use the nvidia-vaapi-driver"
    NVD_BACKEND = "direct";         # Required for nvidia-vaapi-driver
    MOZ_DISABLE_RDD_SANDBOX = "1";  # Required for Firefox/Brave to access the GPU
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
