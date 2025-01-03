return {
  {
    "gbprod/nord.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("nord").setup({
        transparent = true,
        styles = { -- Style to be applied to different syntax groups
          comments = { italic = true }, -- Value is any valid attr-list value `:help attr-list`
          conditionals = { italic = true },
        },
        on_highlights = function(hl, c)
          hl.BlinkCmpGhostText = {
            fg = c.polar_night.brightest,
          }
        end,
      })

      vim.cmd.colorscheme("nord")
    end,
    enabled = true,
  },
}
