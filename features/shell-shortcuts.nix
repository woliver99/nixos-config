# Usefull shell shortcuts I like to have in my terminal

{ ... }:

{
  programs.bash.shellAliases = {
    editconfig = "cd /etc/nixos/";
    explorer = "nautilus . > /dev/null 2>&1"; # Only works on a gnome desktop enviorment
  };
}
