# This configuration contains only essential apps that every system should have

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    htop
    nvtopPackages.full # Allows you to check gpu usage, could be considered bloat but idc
    
    wget
    git

    zip
    unzip
  ];
}
