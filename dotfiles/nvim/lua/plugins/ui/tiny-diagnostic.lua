return {
  "rachartier/tiny-inline-diagnostic.nvim",
  event = "LspAttach",
  priority = 1000,
  enabled = false,
  opts = {},
  init = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
}
