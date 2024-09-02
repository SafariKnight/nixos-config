{ ... }:
{
  programs.nixvim.plugins = {
    cmp = {
      # autoEnableSources = true;
      settings = {
        experimental = {
          ghost_text = true;
        };
        performance = {
          debounce = 60;
          fetchingTimeout = 200;
          maxViewEntries = 30;
        };
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
        snippet.expand.__raw = ''
          function(args)
            vim.snippet.expand(args.body)
          end
        '';
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete({})";
          # behavior = cmp.ConfirmBehavior.Replace,
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
          "<Tab>" = ''
            cmp.mapping(function(fallback)
                        if luasnip.expand_or_locally_jumpable() then
                          luasnip.expand_or_jump()
                        else
                          fallback()
                        end
                      end, { "i", "s" })'';
          "<S-Tab>" = ''
            cmp.mapping(function(fallback)
                        if luasnip.locally_jumpable(-1) then
                          luasnip.jump(-1)
                        else
                          fallback()
                        end
                      end, { "i", "s" })'';
        };
      };
    };

    cmp-nvim-lsp.enable = true; # LSP
    cmp-buffer.enable = true;
    cmp-path.enable = true; # file system paths
    # cmp_luasnip.enable = true; # snippets
    # cmp-cmdline.enable = true; # autocomplete for cmdline
  };
}
