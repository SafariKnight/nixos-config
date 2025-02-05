{
  config,
  pkgs,
  ...
}:
{
  # stylix.targets.neovim.enable = false;
  xdg.configFile.nvim = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim/";
    recursive = true;
  };

  xdg.configFile.nvimo = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/nixos-config/dotfiles/nvim-new/";
    recursive = true;
  };
  programs.neovim = {
    defaultEditor = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
  };
  home.packages = with pkgs; [
    # Language Servers
    vue-language-server
    typescript-language-server
    svelte-language-server
    typescript-language-server
    typescript
    basedpyright
    markdown-oxide
    gopls
    nixd
    tailwindcss-language-server
    vscode-langservers-extracted
    emmet-language-server

    # Formatters
    treefmt
    stylua
    shfmt
    nodejs.pkgs.prettier
    nixfmt-rfc-style
    gofumpt
    golines
    goimports-reviser

    # Linters
    eslint

    # Debuggers
    delve
  ];
  home.sessionVariables = {
    VUE_TYPESCRIPT_PLUGIN = "${pkgs.vue-language-server}/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin";
    TSSERVERJS = "${pkgs.typescript}/lib/node_modules/typescript/lib";
  };
}
