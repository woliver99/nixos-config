# /etc/nixos/printer.nix
#
# This file contains all settings related to printing

{ config, pkgs, ... }:

{
  # Printer config app
  environment.systemPackages = with pkgs; [
    system-config-printer
  ];

  # Enable printing
  services.printing = {
    enable = true;
    drivers = [
      # Epson
      pkgs.epson-escpr
    ];
  };

  # Allow auto discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Enable scanning
  hardware.sane = {
    enable = true;
    extraBackends = [
      # Universal
      pkgs.sane-airscan
      
      # Epson
      pkgs.epsonscan2
    ];
  };
}
