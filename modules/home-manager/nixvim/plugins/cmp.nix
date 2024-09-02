{ ... }:
{
  programs.nixvim.plugins = {
    cmp = {
      autoEnableSources = true;
      settings = {
        sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
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
  };
}
