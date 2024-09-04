{ config, ... }:
{
  stylix.targets.neovim.enable = false;
  xdg.configFile.nvim = {
    # source = ./../../dotfiles/nvim;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim/";
    recursive = true;
  };
  # home.file = {
  #   ".config/nvim" = {
  #     # source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim/";
  #     # source = config.lib.file.mkOutOfStoreSymlink "/home/kareem/nixos-config/dotfiles/nvim";
  #     source = ./../../dotfiles/nvim;
  #     recursive = true;
  #   };
  # };
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
}
