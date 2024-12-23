return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  priority = 1000,
  opts = {
    ai = {},
    comment = {},
    pairs = {},
    icons = {},
    surround = {
      mappings = {
        add = "gza",
        delete = "gzd",
        find = "gzf",
        find_let = "gzF",
        highlight = "gzh",
        replace = "gzr",
        update_n_lines = "gzn",

        suffix_last = "l",
        suffix_next = "n",
      },
    },
  },
  config = function(_, opts)
    for module, options in pairs(opts) do
      require("mini." .. module).setup(options)
    end
  end,
}
