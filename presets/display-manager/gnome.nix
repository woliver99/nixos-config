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

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Enable GNOME networking
  networking.networkmanager.enable = true;

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

  programs.dconf.profiles = {
    # Settings for the Login Screen (GDM)
    gdm.databases = [
      {
        settings = {
          "org/gnome/desktop/peripherals/mouse" = {
            accel-profile = "flat";
          };
        };
      }
    ];

    # Settings for User Sessions (System-wide defaults for all users)
    user.databases = [
      {
        settings = {
          "org/gnome/desktop/wm/preferences" = {
            button-layout = ":minimize,maximize,close";
          };
        };
      }
    ];
  };

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
