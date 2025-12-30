# Nvidia hybrid graphics configuration

{ ... }:

{
  imports = [
    ./nvidia.nix
  ];

  # Needs to be configured per system (example: nvidia dgpu and intel igpu): https://nixos.wiki/wiki/Nvidia
  hardware.nvidia.prime = {
    #intelBusId = "PCI:0:2:0";
    #nvidiaBusId = "PCI:1:0:0";

    sync.enable = true;
  };
}
