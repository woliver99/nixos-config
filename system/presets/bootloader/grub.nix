# Grub bootloader preset

{ pkgs, ... }:

{
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = true;

      default = "saved"; # Set the last booted operating system as default 

      extraInstallCommands = ''
        cfg=$out/boot/grub/grub.cfg

        # 1. Rename the "All configurations" submenu using the full path to sed.
        #${pkgs.gnused}/bin/sed -i "s/All configurations/Profile 'Default'/" "$cfg"

        # 2. Append the UEFI reboot entry to the end of the file.
        echo "
          menuentry 'Reboot to UEFI/BIOS Setup' {
            fwsetup
          }
        " >> $cfg
      '';
    };
  };
}
