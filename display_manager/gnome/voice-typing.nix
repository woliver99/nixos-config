# GNOME voice typing with Blurt

{ config, pkgs, ... }:

{
  # Add custom built whisper to packages
  # Using self built since I get a segfault when using the one in the repository
  nixpkgs.overlays = [
    (final: prev: {
      whisper-cpp-vulkan = final.callPackage ./whisper-cpp.nix { };
    })
  ];

  environment.systemPackages = with pkgs; [
    # Enable Blurt in the extensions app
    gnomeExtensions.blurt
    sox
    xsel
    
    whisper-cpp-vulkan
  ];

  programs.zsh.enable = true;
}
