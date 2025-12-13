# This file contains all settings related to apps

{ pkgs, ... }:

{
  imports = [
    ./development.nix
  ];

  programs.bash.shellAliases = {
    editconfig = "cd /etc/nixos/";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Installation dependent
  users.users.woliver99 = {
    isNormalUser = true;
    description = "Oliver Wuthrich-Giroux";

    packages = with pkgs; [
      youtube-music
    ];

    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install Flatpak
  # Don't forget to add the default repository (per user): flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  services.flatpak.enable = true;

  # Install Firefox (Allows for digital certificates in libreoffice)
  programs.firefox.enable = true;

  # Install Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #GUI
    gparted
    localsend
    filezilla
    pdfarranger
    vlc
    brave

    # LibreOffice
    libreoffice-still
    hunspell
    hunspellDicts.en_CA

    #CLI tools
    htop
    unzip
  ];
}
