# Enables the Gnome desktop environment

{ pkgs, ... }:

{
  # Currently copyous is not in the nix repo but will be added soon: https://github.com/NixOS/nixpkgs/pull/469919
  nixpkgs.overlays = [
    (final: prev: {
      gnomeExtensions = prev.gnomeExtensions // {
        copyous = prev.callPackage ../../modules/gnome-extension-copyous.nix { };
      };
    })
  ];

  # Enable Gnome networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # GNOME extensions (enable them with the extensions app)
  environment.systemPackages = with pkgs; [
    gnomeExtensions.copyous
    gnomeExtensions.appindicator
    gnomeExtensions.gsconnect
    gnomeExtensions.color-picker
  ];

  
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # GSConnect
    ];

    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # GSConnect
    ];
  };

  # Disable mouse acceleration on lockscreen
  programs.dconf.profiles.gdm.databases = [
    {
      settings = {
        "org/gnome/desktop/peripherals/mouse" = {
          accel-profile = "flat";
        };
      };
    }
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

}
