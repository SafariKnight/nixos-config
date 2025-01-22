return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    icons = {
      breadcrumb = "", -- symbol used in the command line area that shows your active key combo
      separator = " ", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
      ellipsis = "…",
      mappings = false,
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { "<leader>f", group = "Find" },
      { "<leader>d", group = "Debug" },
      {
        "<leader>d<space>",
        function()
          wk.show({
            keys = "<leader>d",
            loop = true,
          })
        end,
        group = "Debug",
      },
      {
        "<c-w><space>",
        function()
          wk.show({
            keys = "<c-w>",
            loop = true,
          })
        end,
      },
    })
  end,
}
