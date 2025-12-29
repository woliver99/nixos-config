# This configuration contains apps all apps needed for a complete desktop experience

{ pkgs, ... }:

{
  imports = [
    ./essentials.nix
  ];

  # Install Firefox (Required for digital certificates in libreoffice)
  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    ntfs3g # Needed for using gparted on ntfs partitions

    # -- GUI --
    gparted
    localsend
    filezilla
    pdfarranger
    vlc
    brave
    file-roller

    # LibreOffice
    libreoffice-still
    hunspell
    hunspellDicts.en_CA
  ];
}
