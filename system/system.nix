# System config file

{ pkgs, ... }:

{
  imports = [
    ./presets/hardware/msi-gl65-leopard-10sfk.nix # Import your hardware preset here
    ./presets/bootloader/grub/uefi.nix # Import your bootloader preset here
    ./presets/users/woliver99.nix # Import your user preset here
    ./presets/editor/neovim.nix # Import your editor preset here (comment out if all you need is nano since thats installed by default)
    ./presets/display-manager/gnome.nix # Import your desktop environment here 
    ./presets/apps/developer.nix # Import your apps preset here (options: essentials, full, developer)

    # Add desired features here
    ./features/grub-firmware-entry.nix # Adds a "Reboot to UEFI" entry
    ./features/grub-dualboot.nix # Adds other operating systems (like Windows) to grub
    ./features/flatpak.nix # Installs Flatpak for easy sandbox app installs for users
    ./features/steam.nix # Installs Steam
    ./features/ssh.nix # Installs ssh only accessible via public keys (disables password logins)
    ./features/remote-desktop.nix # Installs Gnome remote desktop which works over rdp (should only be enabled when using Gnome)
    ./features/shell-shortcuts.nix # Usefull shell shortcuts I like to have in my terminal
  ];

  # Per device config
  networking.hostName = "oliver-msi-laptop-nixos"; # Device name
  time.timeZone = "America/Toronto"; # Time zone
  i18n.defaultLocale = "en_CA.UTF-8"; # Internationalisation properties
  nixpkgs.config.allowUnfree = true; # Allow proprietary software to be installed (recommended to be enable)

  # Keymap
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Add extra apps here
  environment.systemPackages = with pkgs; [
    youtube-music # Free Youtube Music with adblocker
  ];
}
