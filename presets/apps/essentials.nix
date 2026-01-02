# This configuration contains only essential apps that every system should have

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    unzip
  ];
}
