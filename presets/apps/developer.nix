# This configuration contains apps all apps needed for a complete developer desktop experience

{ pkgs, ... }:

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

  programs.direnv.enable = true;
  programs.adb.enable = true;

  environment.systemPackages = with pkgs; [
    gh

    # IDEs
    android-studio
    jetbrains.idea-oss
    arduino-ide
    vscode

    #unstable.flutter
    #unstable.antigravity-fhs

    # Python
    python313
    python313Packages.pyserial
  ];

  # For PlatformIO
  services.udev.packages = with pkgs; [ platformio-core.udev ];
}
