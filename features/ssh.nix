# Enable ssh access to this computer via ssh keys

{ ... }:

{
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };
}
