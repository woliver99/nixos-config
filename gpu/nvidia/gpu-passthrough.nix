# /etc/nixos/gpu/nvidia/gpu-passthrough.nix
#
# Nvidia GPU passthrough configuration

{ lib, ... }:

{
  specialisation = {
    "gpu-passthrough" = {
      configuration = {
        imports = [ ./../gpu-passthrough.nix ];

        # Disable Nvidia
        services.xserver.videoDrivers = lib.mkForce [ "modesetting" ];
        #hardware.nvidia.prime.offload = {
          #enable = lib.mkForce false;
          #enableOffloadCmd = lib.mkForce false;
        #};
      };
    };
  };
}
