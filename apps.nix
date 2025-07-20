# /etc/nixos/apps.nix
#
# This file contains all settings related to apps

{ config, pkgs, ... }:

{
  programs.bash.shellAliases = {
    editconfig = "cd /etc/nixos/";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  # Installation dependent
  users.users.woliver99 = {
    isNormalUser = true;
    description = "Oliver Wuthrich-Giroux";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      youtube-music
      vscode
    ];
  };

  # Install Flatpak
  # Don't forget to add the default repository (per user): flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
  services.flatpak.enable = true;

  # Install Firefox (Allows for digital certificates in libreoffice)
  programs.firefox.enable = true;

  # Install Steam
  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Install Neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # Install Docker
  #virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #GUI tools
    gparted
    localsend
    filezilla
    
    #CLI tools
    htop
    
    # Github
    git
    gh

    # Neovim clipboard
    wl-clipboard

    # NvChad
    gcc
    ripgrep

    # GNOME extensions
    gnomeExtensions.pano
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
  ];
}
