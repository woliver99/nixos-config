# GNOME desktop environment configuration

{ pkgs, ... }:

{
  imports = [
    #./login-screen.nix
  ];

  nixpkgs.overlays = [
    (final: prev: {
      gnomeExtensions = prev.gnomeExtensions // {
        copyous = prev.callPackage ./copyous.nix { };
      };
    })
  ];

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # GNOME extensions (enable them with the extensions app)
  environment.systemPackages = with pkgs; [
    gnomeExtensions.copyous
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.color-picker
  ];
}
