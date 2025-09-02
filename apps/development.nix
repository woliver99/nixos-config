# This file contains all settings related to development

{ config, pkgs, ... }:

{
  users.users.woliver99 = {
    # adbusers : Allow interacting with adb as a user
    # dialout : Arduino IDE (allow serial connection)
    extraGroups = [ "adbusers" "dialout" ];
  };

  # Install Neovim
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;

  # Install Docker
  #virtualisation.docker.enable = true;

  # Install Android ADB
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    # Git
    git
    gh

    # IDEs
    android-studio
    arduino-ide
    vscode

    # Python
    python313
    python313Packages.pyserial

    # Neovim
    wl-clipboard
    gcc
    ripgrep
  ];
}
