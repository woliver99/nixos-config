# Installs neovim and configures it as the default editor

{ pkgs, ... }:

let
  nixvim = import (
    builtins.fetchGit {
      url = "https://github.com/nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of Nixvim.
      ref = "nixos-25.11";
    }
  );
in
{
  imports = [ nixvim.nixosModules.nixvim ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    opts = {
      number = true;
      shiftwidth = 2;
      expandtab = true;
      smartindent = false;
    };

    extraPackages = with pkgs; [
      nixfmt-rfc-style
    ];

    clipboard.providers.wl-copy.enable = true;

    keymaps = [
      {
        mode = "n";
        key = "=";
        action = "<cmd>lua require('conform').format({ async = true, lsp_fallback = true })<CR>";
        options.desc = "Format the whole file";
      }
      {
        mode = "v";
        key = "c";
        action = "\"+y"; # Note the \" escaping the quote
        options.desc = "Copy to system clipboard";
      }
      {
        mode = "v";
        key = "x";
        action = "\"+x";
        options.desc = "Cut to system clipboard";
      }
      {
        mode = "v";
        key = "d";
        action = "\"_d";
        options.desc = "Delete without copying";
      }
    ];

    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "macchiato";
    };

    plugins = {
      # File Explorer
      nvim-tree.enable = true;

      # Tab Bar
      bufferline.enable = true;

      # Status Bar
      lualine.enable = true;

      # Nerdfont Icons Support
      web-devicons.enable = true;

      # Automatically detects tabstop/shiftwidth per file
      sleuth.enable = true;

      # Surround visual selections easily (TODO)
      # nvim-surround.enable = true;

      # Syntax Highlighting
      treesitter = {
        enable = true;
        nixGrammars = true;
        grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;

        settings = {
          highlight = {
            enable = true;
            disable = [ "gitcommit" ];
          };
          indent.enable = true;
          folding.enable = true;
        };
      };

      # Completion
      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          mapping = {
            # (Tab) to confirm the selection
            "<Tab>" = "cmp.mapping.confirm({ select = true })";

            # (Shift-Tab) to close the completion menu
            "<S-Tab>" = "cmp.mapping.close()";

            # (Up and Down arrows) to cycle through tablist
            "<Up>" = "cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' })";
            "<Down>" = "cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' })";

            # (Ctrl-Space) Open tab menu
            "<C-Space>" = "cmp.mapping.complete()";
          };

          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          rust_analyzer = {
            enable = true;
            package = null;
            installCargo = false;
            installRustc = false;
          };
        };
      };

      conform-nvim = {
        enable = true;
        settings = {
          formatters_by_ft = {
            nix = [ "nixfmt" ];
            #rust = [ "rustfmt" ];
          };
        };

      };
    };
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
