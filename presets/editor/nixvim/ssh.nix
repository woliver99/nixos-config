# My nixvim config with wl-clipboard

{ pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      nvim-osc52
    ];

    extraConfigLua = ''
      local function copy(lines, _)
        require('osc52').copy(table.concat(lines, '\n'))
      end

      local function paste()
        -- [!] FIX: We used double quotes ("") here to avoid closing the Nix string
        return {vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("")}
      end

      vim.g.clipboard = {
        name = 'osc52',
        copy = {
          ['+'] = copy,
          ['*'] = copy,
        },
        paste = {
          ['+'] = paste,
          ['*'] = paste,
        },
      }

      -- Optional: Automatically copy to system clipboard on any yank
      -- vim.opt.clipboard:append("unnamedplus")
    '';
  };
}
