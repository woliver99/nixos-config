# Grub bootloader preset

{ ... }:

{
  imports = [
    ../../../modules/bootloader/grub-reboot-to-bios-entry.nix
  ];

  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;

      default = "saved"; # Set the last booted operating system as default
    };
  };
}
