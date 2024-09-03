{ inputs, ... }:
# let
#   helper = config.lib.nixvim;
# in
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

    colorschemes.nord.enable = true;
  };
}
