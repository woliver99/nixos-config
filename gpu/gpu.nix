# /etc/nixos/gpu/gpu.nix
#
# GPU general config

{ config, lib, pkgs, ... }:

{
  # Choose your main GPU
  # Installation dependent
  imports = [
    ./nvidia/nvidia.nix
  ];

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
  };
}
