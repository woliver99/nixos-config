{ lib, ... }:

{
  users.users.wselena99 = {
    isNormalUser = true;
    uid = lib.mkOverride 990 1000;
    description = "Selena Wuthrich-Giroux";

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
