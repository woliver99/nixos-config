# GPU general config

{ ... }:

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
