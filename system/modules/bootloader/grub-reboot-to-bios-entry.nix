# Add reboot to BIOS entry in grub

{ ... }:

{
  boot.loader.grub.extraInstallCommands = ''
    cfg=$out/boot/grub/grub.cfg

    echo "
      menuentry 'Reboot to UEFI/BIOS Setup' {
        fwsetup
      }
    " >> $cfg
  '';
}
