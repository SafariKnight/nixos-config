{ config, pkgs, ... }:
{
  stylix.targets.neovim.enable = false;
  xdg.configFile.nvim = {
    # source = ./../../dotfiles/nvim;
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim/";
    recursive = true;
  };
  home.packages = with pkgs; [
    shfmt
    lua-language-server
    stylua
    vue-language-server
    typescript
    vscode-langservers-extracted
    emmet-language-server
    nodePackages.prettier
    gopls
    gofumpt
    goimports-reviser
    golines
    rust-analyzer
    cargo
    nixd
    tailwindcss-language-server
  ];
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
    extraPackages = with pkgs; [
      shfmt
      lua-language-server
      stylua
      vue-language-server
      typescript
      vscode-langservers-extracted
      emmet-language-server
      nodePackages.prettier
      gopls
      gofumpt
      goimports-reviser
      golines
      rust-analyzer
      nixd
      tailwindcss-language-server
    ];
  };
}
