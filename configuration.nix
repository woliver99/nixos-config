# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./bootloader.nix
    ./display_manager/display-manager.nix
    ./gpu/gpu.nix
    ./network.nix
    ./apps/apps.nix
    ./printer.nix
    ./remote-desktop.nix
  ];
  
  # Installation dependent
  networking.hostName = "oliver-msi-laptop-nixos";

  # Set your time zone.
  # Installation dependent
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  # Installation dependent
  i18n.defaultLocale = "en_CA.UTF-8";

  # Configure keymap in X11
  # Installation dependent
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Fonts
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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable drawing tablet drivers
  hardware.opentabletdriver.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
