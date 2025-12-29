# This file contains all settings related to networking

{ pkgs, ... }:

{
  networking.networkmanager.enable = true;

  # VPN
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
    networkmanager-l2tp
  ];

  # LocalSend: 53317
  # GSConnect: 1714-1764
  # WireGuard: 51821
  # Gnome Remote Desktop 2: 3390 (T+U)
  # CircularPath: 8000 (T)
  networking.firewall = {
    enable = true;

    allowedTCPPorts = [
      53317
      3390
      8000
      11434
    ];
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
    ];

    allowedUDPPorts = [
      53317
      51821
      3390
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      }
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

  # Printer discovery
  services.avahi.openFirewall = true;
}
