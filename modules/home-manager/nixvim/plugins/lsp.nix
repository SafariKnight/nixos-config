{ pkgs, ... }:
{
  home.packages = [ pkgs.emmet-language-server ];
  programs.nixvim.plugins = {
    lsp = {
      enable = true;
      servers = {
        nixd.enable = true;
        lua-ls.enable = true;
        html.enable = true;
        cssls.enable = true;
        tailwindcss.enable = true;
        jsonls.enable = true;
        taplo.enable = true;
      };
      keymaps = {
        lspBuf = {
          K = "hover";
          gD = "references";
          gd = "definition";
          gi = "implementation";
          gt = "type_definition";
          crr = "code_action";
          "<leader>ca" = "code_action";
          crn = "rename";
          crf = "format";
        };
      };
      postConfig = ''
        require("lspconfig").emmet_language_server.setup({
            capabilities = capabilities
          })
      '';
    };
  };
}
