# /etc/nixos/gpu/nvidia/hybrid-graphics.nix
#
# Nvidia hybrid graphics configuration

{ config, lib, pkgs, ... }:

{
  # Installation dependent
  imports = [
    ./gpu-passthrough.nix # Enable GPU passthrough boot option
  ];  

  hardware.nvidia.prime = {
    # Installation dependent
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
    
    sync.enable = true;
  };
}
