# This file contains all settings related to development

{ pkgs, config, ... }:

let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) { config = config.nixpkgs.config; };
in
{
  users.users.woliver99 = {
    # adbusers : Allow interacting with adb as a user
    # dialout : Arduino IDE (allow serial connection)
    extraGroups = [
      "adbusers"
      "dialout"
    ];
  };

  # Install Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
  };

  # Install Docker
  virtualisation = {
    #docker.enable = true;

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # Install Android ADB
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    # Git
    git
    gh

    # IDEs
    android-studio
    unstable.antigravity-fhs
    jetbrains.idea-oss
    arduino-ide
    vscode

    unstable.flutter

    # Python
    python313
    python313Packages.pyserial

    # Neovim
    wl-clipboard
    gcc
    ripgrep

    # Language Servers
    lua-language-server
    nixd

    # Formatters
    nixfmt-rfc-style
  ];

  # For PlatformIO
  services.udev.packages = with pkgs; [ platformio-core.udev ];
}
