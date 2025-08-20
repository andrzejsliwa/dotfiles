return {
  {
    "coder/claudecode.nvim",
    dependencies = { "folke/snacks.nvim" },
    config = true,
    keys = {
      { "<leader>a", nil, desc = "AI/Claude Code" },
      { "<leader>ac", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
      { "<leader>af", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
      { "<leader>ar", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
      { "<leader>aC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
      { "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
      { "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add current buffer" },
      { "<leader>as", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
      {
        "<leader>as",
        "<cmd>ClaudeCodeTreeAdd<cr>",
        desc = "Add file",
        ft = { "NvimTree", "neo-tree", "oil", "minifiles" },
      },
      -- Diff management
      { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
      { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny diff" },
    },
  },
  {
    "pittcat/claude-fzf.nvim",
    dependencies = {
      "ibhagwan/fzf-lua",
      "coder/claudecode.nvim",
    },
    opts = {
      auto_context = true,
      batch_size = 10,
    },
    cmd = {
      "ClaudeFzf",
      "ClaudeFzfFiles",
      "ClaudeFzfGrep",
      "ClaudeFzfBuffers",
      "ClaudeFzfGitFiles",
      "ClaudeFzfDirectory",
    },
    keys = {
      { "<leader>if", "<cmd>ClaudeFzfFiles<cr>", desc = "Claude: Add files" },
      { "<leader>ig", "<cmd>ClaudeFzfGrep<cr>", desc = "Claude: Search and add" },
      { "<leader>ib", "<cmd>ClaudeFzfBuffers<cr>", desc = "Claude: Add buffers" },
      { "<leader>igf", "<cmd>ClaudeFzfGitFiles<cr>", desc = "Claude: Add Git files" },
      { "<leader>id", "<cmd>ClaudeFzfDirectory<cr>", desc = "Claude: Add directory files" },
    },
  },
  {
    "pittcat/claude-fzf-history.nvim",
    dependencies = { "ibhagwan/fzf-lua" },
    config = function()
      require("claude-fzf-history").setup()
    end,
    cmd = { "ClaudeHistory", "ClaudeHistoryDebug" },
    keys = {
      { "<leader>ch", "<cmd>ClaudeHistory<cr>", desc = "Claude History" },
    },
  },
}
