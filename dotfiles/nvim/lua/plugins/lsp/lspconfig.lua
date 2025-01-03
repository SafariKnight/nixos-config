---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNew" },
  opts = {
    custom_servers = { -- Servers that need more than lspconfig[server].setup()
      "ts_ls",
      "volar",
    },
    servers = {
      lua_ls = require("plugins.lsp.servers.lua_ls"),
      gdscript = {},
      markdown_oxide = {},
      tailwindcss = {},
      cssls = {},
      html = {},
      emmet_language_server = {},
    },
  },
  config = function(_, opts)
    local signs = {
      Error = require("config.icons").BoldError,
      Warn = require("config.icons").BoldWarning,
      Hint = require("config.icons").BoldHint,
      Info = require("config.icons").BoldInformation,
    }

    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      desc = "LSP actions",
      callback = function(_, buffer)
        local map = function(mode, lhs, rhs, options)
          options = vim.tbl_deep_extend("force", options, { buffer = buffer })
          vim.keymap.set(mode, lhs, rhs, options)
        end

        map("n", "gd", vim.lsp.buf.definition, { desc = "Go to declaration" })
        map("n", "gs", vim.lsp.buf.signature_help, { desc = "Signature Help" })

        -- Designed like new default mappings
        map("n", "crr", vim.lsp.buf.code_action, { desc = "Code Action" })
        map(
          { "v", "x" },
          "<leader>ca",
          vim.lsp.buf.code_action,
          { desc = "Code Action" }
        )
        map("n", "crn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
        map("n", "crf", vim.lsp.buf.format, { desc = "Format" })

        map("n", "crs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)"})
        map("n", "crd", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "Definitions / References / ... (Trouble)"})
        map("n", "crx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Workspace Diagnostics (Trouble)"})
        map("n", "crx", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Document Diagnostics (Trouble)"})
      end,
    })

    local lspconfig = require("lspconfig")
    local lspconfig_defaults = lspconfig.util.default_config
    lspconfig_defaults.capabilities =
      require("blink.cmp").get_lsp_capabilities(lspconfig_defaults.capabilities)

    for server, config in pairs(opts.servers) do
      lspconfig[server].setup(config)
    end

    for _, server in ipairs(opts.custom_servers) do
      require("plugins.lsp.servers." .. server)
    end
  end,
}
