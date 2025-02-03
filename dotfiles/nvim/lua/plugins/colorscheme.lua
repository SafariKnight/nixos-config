local h = setmetatable({}, {
  __newindex = function(_, k, v) -- could this exist everywhere pls
    vim.api.nvim_set_hl(0, k, v)
  end
})
return {
  {
    "gbprod/nord.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require("nord").setup({
        transparent = true,
        styles = {                      -- Style to be applied to different syntax groups
          comments = { italic = true }, -- Value is any valid attr-list value `:help attr-list`
          conditionals = { italic = true },
        },
        on_highlights = function(hl, c)
          hl.BlinkCmpGhostText = {
            fg = c.polar_night.brightest,
          }
          hl.SignColumn = {
            fg = c.aurora.purple,
          }
        end,
      })

      vim.cmd.colorscheme("nord")
    end,
    enabled = false,
  },
  {
    "sainnhe/gruvbox-material",
    priority = 1000,
    lazy = false,
    enabled = true,
    config = function()
      local g = vim.g
      g.gruvbox_material_better_performance = 1
      g.gruvbox_material_enable_italic = 1
      g.gruvbox_material_dim_inactive_windows = 1
      vim.cmd.colorscheme("gruvbox-material")

      local config = vim.fn['gruvbox_material#get_configuration']()
      local palette = vim.fn['gruvbox_material#get_palette'](config.background, config.foreground, config
        .colors_override)

      h.BlinkCmpGhostText = {
        fg = palette.bg5[1]
      }
      h.SignColumn = {
        fg = palette.purple[1]
      }
    end,
  },
}
