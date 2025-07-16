# /etc/nixos/network.nix
#
# This file contains all settings related to networking

{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # LocalSend: 53317
  # GSConnect: 1714-1764
  networking.firewall = {
    enable = true;

    allowedTCPPorts = [ 53317 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    allowedUDPPorts = [ 53317 ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };

  # Steam
  programs.steam = {
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
}
