{ ... }:
{
  programs.nixvim.plugins = {
    typescript-tools = {
      enable = true;
      settings.tsserverPlugins = [ "@vue/typescript-plugin" ];
    };
    lsp.servers.tsserver.enable = true;
    lsp.servers.tsserver.filetypes = [
      "javascript"
      "javascriptreact"
      "javascript.jsx"
      "typescript"
      "typescriptreact"
      "typescript.tsx"
      "vue"
    ];
  };
}
