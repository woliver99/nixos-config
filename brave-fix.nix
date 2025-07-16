# /etc/nixos/brave-fix.nix
#
# This module automatically creates a systemd service for each normal user
# to clean up the Brave Browser SingletonLock file on system boot
# since Brave dosen't like it when your hostname changes

{ config, lib, pkgs, ... }:

{
  config = {
    systemd.services = lib.mkMerge (lib.mapAttrsToList (userName: user:
        lib.mkIf user.isNormalUser {
        "brave-lock-cleanup-${userName}" = {
          description = "Cleans up Brave lock file for ${userName}";

          serviceConfig = {
            Type = "oneshot";
            User = userName;
            ExecStart = "${pkgs.coreutils}/bin/rm -f ${user.home}/.config/BraveSoftware/Brave-Browser/SingletonLock";
          };

          wantedBy = [ "multi-user.target" ];
        };
      })
    config.users.users);
  };
}
