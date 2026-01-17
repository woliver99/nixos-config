# winapps configured for my laptop, will be made useable on other systems

{ pkgs, ... }:

let
  winapps-src = builtins.fetchTarball {
    url = "https://github.com/winapps-org/winapps/archive/main.tar.gz";
    # You can optionally add a sha256 hash here to pin the version,
    # but leaving it empty fetches the latest 'main' every time you rebuild.
  };

  system = pkgs.stdenv.hostPlatform.system;

  winapps-pkg = (import winapps-src).packages."${system}".winapps;
  #winapps-launcher = (import winapps-src).packages."${system}".winapps-launcher;
in
{
  environment.systemPackages = with pkgs; [
    winapps-pkg
    #winapps-launcher

    freerdp
    iproute2
    libnotify
    dialog
    jq
    netcat-openbsd
  ];

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.woliver99.extraGroups = [ "libvirtd" "kvm" ];

  environment.sessionVariables = {
    LIBVIRT_DEFAULT_URI = [ "qemu:///system" ];
  };
}
