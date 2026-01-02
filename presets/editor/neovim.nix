# Installs neovim and configures it as the default editor

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    gcc
    ripgrep

    # Language Servers
    lua-language-server
    nixd

    # Formatters
    nixfmt-rfc-style
  ];
}
