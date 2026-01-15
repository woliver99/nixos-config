# Common config for a standard proxmox virtual machine

{ ... }:

{
  # Automatically grow the filesystem on boot.
  boot.growPartition = true;

  # Enable the QEMU Guest Agent for proper communication with Proxmox.
  services.qemuGuest.enable = true;
}
