return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  },

  -- stylua: ignore
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end,                                       desc = "Breakpoint", },
    { "<leader>dB", function() require("dap").toggle_breakpoint(vim.fn.input("Breakpoint Condition: ")) end, desc = "Conditonal Breakpoint", },
    { "<leader>dc", function() require("dap").continue() end,                                                desc = "Run/Continue", },
    { "<leader>di", function() require("dap").step_into() end,                                               desc = "Step Into", },
    { "<leader>do", function() require("dap").step_out() end,                                                desc = "Step Out", },
    { "<leader>dO", function() require("dap").step_over() end,                                               desc = "Step Over", },
    { "<leader>dh", function() require("dap").step_back() end,                                               desc = "Step Back", },
    { "<leader>dj", function() require("dap").down() end,                                                    desc = "Down", },
    { "<leader>dk", function() require("dap").up() end,                                                      desc = "Up", },
    { "<leader>dr", function() require("dap").restart() end,                                                 desc = "Restart Session", },
    { "<leader>dl", function() require("dap").run_last() end,                                                desc = "Run Last" },
    -- { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    -- { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    -- { "<leader>dc", function() require("dap").continue() end,                                             desc = "Run/Continue" },
    -- { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
    -- { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    -- { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to Line (No Execute)" },
    -- { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
    -- { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
    -- { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
    -- { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
    -- { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
    -- { "<leader>dP", function() require("dap").pause() end,                                                desc = "Pause" },
    -- { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
    -- { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
    -- { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
    -- { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  },

  config = function()
    vim.api.nvim_set_hl(
      0,
      "DapStoppedLine",
      { default = true, link = "Visual" }
    )
    require("dap").adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = { os.getenv("JS_DEBUG"), "${port}" },
      },
    }

    require("dap").configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }
  end,
}
