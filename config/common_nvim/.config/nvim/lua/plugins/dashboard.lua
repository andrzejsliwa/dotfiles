return {
  {
    {
      "nvimdev/dashboard-nvim",
      event = "VimEnter",
      config = function()
        require("dashboard").setup({
          theme = "hyper",
          config = {
            week_header = {
              enable = true,
            },
            shortcut = {
              { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
              { desc = " Extras", group = "Extras", action = "LazyExtras", key = "e" },

              {
                icon = " ",
                icon_hl = "@variable",
                desc = "Files",
                group = "Label",
                action = "lua LazyVim.pick()()",
                key = "f",
              },
              {
                desc = " dotfiles",
                group = "Number",
                action = "lua LazyVim.pick.config_files()()",
                key = "d",
              },
            },
          },
        })
      end,
      dependencies = { { "nvim-tree/nvim-web-devicons" } },
    },
  },
}
