# /etc/nixos/display_manager/display-manager.nix
#
# Choose your desktop environment here

{ config, pkgs, ... }:

{
  # Choose your display manager
  imports = [
    ./gnome/gnome.nix
  ];

  # Enable the X11 windowing system.
  services.xserver.enable = true;
}
