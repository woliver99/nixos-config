# Adds support for printing to most printers

{ pkgs, ... }:

{
  # Config app
  environment.systemPackages = with pkgs; [
    system-config-printer
  ];

  # Printing
  services.printing = {
    enable = true;
    browsed.enable = false; # Disable auto adding printers
  };

  # Auto discovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Scanning
  hardware.sane = {
    enable = true;
    extraBackends = [
      pkgs.sane-airscan # Universal
    ];
  };
}
