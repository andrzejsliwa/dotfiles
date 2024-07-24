return {
  {
    {
      "mfussenegger/nvim-dap-python",
      dependencies = { "mfussenegger/nvim-dap" },
      enabled = true,
      config = function()
        local status, dap = pcall(require, "dap")
        if not status then
          return
        end
        local dappython
        status, dappython = pcall(require, "dap-python")
        if not status then
          return
        end
        dap.configurations.python = {
          {
            type = "python",
            request = "launch",
            name = "Launch file (justMyCode = false)",
            program = "${file}",
            justMyCode = false,
          },
          {

            type = "python",
            request = "launch",
            name = "Launch file with arguments (justMyCode = false)",
            program = "${file}",
            justMyCode = false,
            args = function()
              local args_string = vim.fn.input("Arguments: ")
              return vim.split(args_string, " +")
            end,
          },
          {
            type = "python",
            request = "launch",
            name = "Launch file (console = integratedTerminal, justMyCode = false)",
            program = "${file}",
            console = "integratedTerminal",
            justMyCode = false,
            --pythonPath = opts.pythonPath,
          },
          {

            type = "python",
            request = "launch",
            name = "Launch file with arguments (console = integratedTerminal, justMyCode = false)",
            program = "${file}",
            console = "integratedTerminal",
            justMyCode = false,
            --pythonPath = opts.pythonPath,
            args = function()
              local args_string = vim.fn.input("Arguments: ")
              return vim.split(args_string, " +")
            end,
          },
        }
        dappython.setup("python", {
          include_configs = true,
          console = "integratedTerminal",
          pythonPath = nil,
        })
      end,
    },
    {
      "nvim-neotest/neotest-python",
    },
    {
      "nvim-neotest/neotest",
      config = function()
        require("neotest").setup({
          adapters = { require("neotest-python") },
        })
      end,
    },
    -- {
    --   "pappasam/nvim-repl",
    --   init = function()
    --     vim.g["repl_filetype_commands"] = {
    --       javascript = "node",
    --       python = "pipenv run ipython --no-autoindent",
    --     }
    --   end,
    --   keys = {
    --     { "<leader>rt", "<CMD>ReplToggle<CR>", mode = "n", { desc = "Toggle REPL" } },
    --     { "<leader>rr", "<CMD>ReplClear<CR>", mode = "n", { desc = "Clear REPL" } },
    --     { "<leader>rc", "<CMD>ReplRunCell<CR>", mode = "n", { desc = "Send cell to REPL" } },
    --     { "<leader>rl", "<Plug>ReplSendLine", mode = "n", { desc = "Send line to REPL" } },
    --     { "<leader>rv", "<Plug>ReplSendVisual", mode = "v", { desc = "Send selection to REPL" } },
    --   },
    -- },
    {
      "hkupty/iron.nvim",

      config = function(plugins, opts)
        local iron = require("iron.core")
        local view = require("iron.view")
        iron.setup({
          config = {
            -- Whether a repl should be discarded or not
            scratch_repl = true,
            -- Your repl definitions come here
            repl_definition = {
              python = {
                -- Can be a table or a function that
                -- returns a table (see below)
                command = { "pipenv", "run", "ipython", "--no-autoindent" },
                format = require("iron.fts.common").bracketed_paste_python,
              },
            },

            -- How the repl window will be displayed
            -- See below for more information
            repl_open_cmd = view.split("40%"),
          },
          -- Iron doesn't set keymaps by default anymore.

          -- You can set them here or manually add keymaps to the functions in iron.core

          keymaps = {
            send_motion = "<space>rc",
            visual_send = "<space>rc",
            send_file = "<space>rf",
            send_line = "<space>rl",
            send_mark = "<space>rm",
            mark_motion = "<space>rmc",
            mark_visual = "<space>rmc",
            remove_mark = "<space>rmd",
            cr = "<space>r<cr>",
            interrupt = "<space>r<space>",
            exit = "<space>rq",

            clear = "<space>rx",
          },
          -- If the highlight is on, you can change how it looks
          -- For the available options, check nvim_set_hl
          highlight = {
            italic = true,
          },
          ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
        })

        -- iron also has a list of commands, see :h iron-commands for all available commands
        vim.keymap.set("n", "<space>rs", "<cmd>IronRepl<cr>")

        vim.keymap.set("n", "<space>rr", "<cmd>IronRestart<cr>")
        vim.keymap.set("n", "<space>rF", "<cmd>IronFocus<cr>")
        vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
      end,
    },
  },
}
