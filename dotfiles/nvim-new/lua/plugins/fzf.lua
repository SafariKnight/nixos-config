return {
  "ibhagwan/fzf-lua",
  command = { "FzfLua" },
  keys = {
    { "<leader>ff", function() require("fzf-lua").files() end, desc = "Files" },
    { "<leader><space>", function() require("fzf-lua").files() end, desc = "Find Files" },
  },
}
