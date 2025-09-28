# This file contains all settings related to networking

{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # LocalSend: 53317
  # GSConnect: 1714-1764
  # WireGuard: 51821
  # Gnome Remote Desktop 2: 3390 (T+U)
  networking.firewall = {
    enable = true;

    allowedTCPPorts = [ 53317 3390 ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    allowedUDPPorts = [ 53317 51821 3390 ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    # Allow WireGuard traffic through the reverse path filter
    extraCommands = ''
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 51821 -j RETURN
      ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 51821 -j RETURN
    '';
    extraStopCommands = ''
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 51821 -j RETURN || true
      ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 51821 -j RETURN || true
    '';
  };

  # Steam
  programs.steam = {
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };

  # Printer discovery
  services.avahi.openFirewall = true;
}
