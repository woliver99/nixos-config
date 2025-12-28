# System config file

{ ... }:

{
  imports = [
    ./presets/hardware/msi-gl65-leopard-10sfk.nix # Import your hardware preset here
    ./presets/users/woliver99.nix # Import your user preset here

    # Add desired features here
    ./features/ssh.nix
    ./features/remote-desktop.nix
  ];

  # Per device config
  networking.hostName = "oliver-msi-laptop-nixos"; # Device name
  time.timeZone = "America/Toronto"; # Time zone
  i18n.defaultLocale = "en_CA.UTF-8"; # Internationalisation properties

  # Keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
