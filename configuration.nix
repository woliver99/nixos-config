{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./system/system.nix
    ./display_manager/display-manager.nix
    ./gpu/gpu.nix
    ./network.nix
    ./printer.nix
  ];

  fonts = {
    # Nerdfonts are repackaged fonts with extra icons
    packages = with pkgs; [ nerd-fonts.adwaita-mono ];
    fontconfig.defaultFonts.monospace = [ "AdwaitaMono Nerd Font Mono" ];
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Enable drawing tablet drivers
  #hardware.opentabletdriver.enable = true; # For some reason this is causing crashes keep disabled

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
