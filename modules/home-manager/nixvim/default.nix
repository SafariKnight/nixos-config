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
    # luaLoader.enable = true;
    # performance = {
    #   byteCompileLua.enable = true;
    # };

    viAlias = true;
    vimAlias = true;

    extraPlugins = [ pkgs.vimPlugins.quick-scope ];
    colorschemes.nord.enable = true;
  };
}
