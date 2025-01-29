return {
  "ibhagwan/fzf-lua",
  command = { "FzfLua" },
  opts = function()
    local c = require("nord.colors")
    return {
      fzf_colors = {
        ["bg+"] = c.palette.polar_night.bright,
        ["fg+"] = c.palette.snow_storm.brightest,
        ["pointer"] = c.palette.polar_night.bright,
        ["gutter"] = "-1",
        ["border"] = c.palette.polar_night.origin,
        ["preview-border"] = c.palette.polar_night.origin,
        ["separator"] = c.palette.polar_night.origin,
      },
    }
  end,
  keys = {
    {
      "<leader>ff",
      function()
        require("fzf-lua").files()
      end,
      desc = "Files",
    },
    {
      "<leader><space>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find Files",
    },
  },
  config = function(_, opts)
    local fzf = require("fzf-lua")
    fzf.setup(opts)
    fzf.register_ui_select()
  end,
}
