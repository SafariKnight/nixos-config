{ inputs, pkgs, ... }:
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./options.nix
    ./plugins/cmp.nix
    ./plugins/lsp.nix
    ./plugins/fzf.nix
    ./plugins/tmux-navigator.nix
    ./plugins/markview.nix
    ./plugins/mini.nix
    ./plugins/none-ls.nix
    ./plugins/grapple.nix
    ./plugins/oil.nix
    ./plugins/which-key.nix
    ./plugins/treesitter.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    luaLoader.enable = true;
    performance = {
      byteCompileLua.enable = true;
    };
    keymaps = [
      {
        action = "maJ'a";
        key = "J";
        options.desc = "Append next line on current line";
      }
      {
        action = "v:count == 0 ? 'gk' : 'k'";
        key = "k";
        options.desc = "up";
        options.expr = true;
      }
      {
        action = "v:count == 0 ? 'gj' : 'j'";
        key = "j";
        options.desc = "down";
        options.expr = true;
      }
    ];

    viAlias = true;
    vimAlias = true;

    extraPlugins = [ pkgs.vimPlugins.quick-scope ];
    colorschemes.nord.enable = true;
  };
}
