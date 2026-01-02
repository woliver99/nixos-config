# This configuration contains apps all apps needed for a complete developer desktop experience

{ pkgs, config, ... }:

let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) { config = config.nixpkgs.config; };
in
{
  imports = [
    ./full.nix
  ];

  virtualisation.podman = {
    enable = true;

    # Create a `docker` alias for podman, to use it as a drop-in replacement
    dockerCompat = true;

    # Required for containers under podman-compose to be able to talk to each other.
    defaultNetwork.settings.dns_enabled = true;
  };

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
  ];

  # For PlatformIO
  services.udev.packages = with pkgs; [ platformio-core.udev ];
}
