{ config, ... }:
{
  xdg.configFile.nvim = {
    # source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/nvim;
    source = ../../dotfiles/nvim;
    recursive = true;
  };
  programs.neovim = {
    defaultEditor = true;
    enable = true;
  };
}
