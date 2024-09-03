{ ... }:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "c"
          "lua"
          "vim"
          "vimdoc"
          "query"
          "javascript"
          "typescript"
          "html"
          "css"
          "scss"
          "vue"
          "go"
          "gosum"
          "gomod"
          "gotmpl"
        ];
        highlight.enable = true;
        indent = {
          enable = true;
          disable = [ "html" ];
        };
        textobjects = {
          select = {
            enable = true;
            lookahead = true;
            keymaps = {
              "af" = "@function.outer";
              "if" = "@function.inner";
              "ac" = "@class.outer";
              "ic" = {
                query = "@class.inner";
                desc = "Select inner part of a class region";
              };
            };
          };
        };
      };
    };

  };
}
