{...}: {
  programs.nixvim.plugins = {
    cmp = {
      enable = true;
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
        formatting = {
          fields = [
            "kind"
            "abbr"
            "menu"
          ];
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {
            name = "buffer"; # text within current buffer
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
            keywordLength = 3;
          }
        ];
        # snippet.expand.__raw = ''
        #   function(args)
        #     vim.snippet.expand(args.body)
        #   end
        # '';
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete({ behavior = cmp.ConfirmBehavior.Replace })";
          # behavior = cmp.ConfirmBehavior.Replace,
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
          # "<Tab>" = ''
          #   cmp.mapping(function(fallback)
          #               if luasnip.expand_or_locally_jumpable() then
          #                 luasnip.expand_or_jump()
          #               else
          #                 fallback()
          #               end
          #             end, { "i", "s" })'';
          # "<S-Tab>" = ''
          #   cmp.mapping(function(fallback)
          #               if luasnip.locally_jumpable(-1) then
          #                 luasnip.jump(-1)
          #               else
          #                 fallback()
          #               end
          #             end, { "i", "s" })'';
        };
      };
    };
  };
}
