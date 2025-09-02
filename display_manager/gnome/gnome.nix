# /etc/nixos/display_manager/gnome/gnome.nix
#
# GNOME desktop environment configuration

{ config, pkgs, ... }:

{
  imports = [
    ./login-screen.nix
    # Broken
    #./voice-typing.nix
  ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # GNOME extensions (enable them with the extensions app)
  environment.systemPackages = with pkgs; [
    gnomeExtensions.pano
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect 
    gnomeExtensions.color-picker
  ];
}
