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
    extraGroups = [ "networkmanager" "wheel" "adbusers" ];
    packages = with pkgs; [
      youtube-music
      vscode
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

  # Install Neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # Install Docker
  virtualisation.docker.enable = true;

  # Install Android ADB
  programs.adb.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #GUI tools
    gparted
    localsend
    filezilla
    pdfarranger
    android-studio
    linphone
    jami

    # LibreOffice
    libreoffice-still
    hunspell
    hunspellDicts.en_CA

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
  ];
}
