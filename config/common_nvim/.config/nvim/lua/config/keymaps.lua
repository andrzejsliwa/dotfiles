-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", ";", ":")
vim.keymap.set("n", "<leader>o", "<C-o>")

local wrap = function(func, ...)
  local args = { ... }
  return function()
    func(unpack(args))
  end
end

local function send_text_to_terminal(text)
  local terminal = Snacks.terminal.get()
  local term_bufnr = terminal and terminal.buf
  local enter = "\n"
  assert(term_bufnr, "ERROR: No terminal buffer")

  -- toggle terminal if not visible
  if not vim.iter(vim.fn.tabpagebuflist()):find(function(b)
    return b == term_bufnr
  end) then
    Snacks.terminal()
  end

  -- send commands to terminal
  vim.api.nvim_chan_send(vim.bo[term_bufnr].channel, text .. enter)
  -- scroll to bottom
  vim.api.nvim_buf_call(term_bufnr, function()
    local info = vim.api.nvim_get_mode()
    if info and (info.mode == "n" or info.mode == "nt") then
      vim.cmd("normal! G")
    end
  end)
end

local function send_lines_to_terminal(mode)
  local modes = {
    visual = { "v", "." },
    normal = { ".", "." },
  }
  local start_char, end_char = unpack(modes[mode])
  local lines = vim.api.nvim_buf_get_lines(0, vim.fn.line(start_char) - 1, vim.fn.line(end_char), false)
  local terminal = Snacks.terminal.get()
  local term_bufnr = terminal and terminal.buf
  local enter = "\n"
  assert(term_bufnr, "ERROR: No terminal bufnr")
  -- toggle terminal if not visible
  if not vim.iter(vim.fn.tabpagebuflist()):find(function(b)
    return b == term_bufnr
  end) then
    Snacks.terminal()
  end
  -- strip trailing whitespaces
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
    lines[#lines] = nil
  end
  -- send commands to terminal
  vim.api.nvim_chan_send(vim.bo[term_bufnr].channel, table.concat(lines, enter) .. enter)
  -- scroll to bottom
  vim.api.nvim_buf_call(term_bufnr, function()
    local info = vim.api.nvim_get_mode()
    if info and (info.mode == "n" or info.mode == "nt") then
      vim.cmd("normal! G")
    end
  end)
end

local function load_current_file_to_forth()
  local file = vim.fn.expand("%")
  send_text_to_terminal('s" ' .. file .. '" included')
end

local send_lines_to_terminal = function(mode)
  local modes = {
    visual = { "v", "." },
    normal = { ".", "." },
  }
  local start_char, end_char = unpack(modes[mode])
  local lines = vim.api.nvim_buf_get_lines(0, vim.fn.line(start_char) - 1, vim.fn.line(end_char), false)
  local terminal = Snacks.terminal.get()
  local term_bufnr = terminal and terminal.buf
  local enter = "\n"
  assert(term_bufnr, "ERROR: No terminal bufnr")
  -- toggle terminal if not visible
  if not vim.iter(vim.fn.tabpagebuflist()):find(function(b)
    return b == term_bufnr
  end) then
    Snacks.terminal()
  end
  -- strip trailing whitespaces
  while #lines > 0 and vim.trim(lines[#lines]) == "" do
    lines[#lines] = nil
  end
  -- send commands to terminal
  vim.api.nvim_chan_send(vim.bo[term_bufnr].channel, table.concat(lines, enter) .. enter)
  -- scroll to bottom
  vim.api.nvim_buf_call(term_bufnr, function()
    local info = vim.api.nvim_get_mode()
    if info and (info.mode == "n" or info.mode == "nt") then
      vim.cmd("normal! G")
    end
  end)
end

vim.keymap.set("n", "<leader>'", load_current_file_to_forth, { desc = "Load current file to Forth" })
vim.keymap.set("n", "<leader>;", wrap(send_lines_to_terminal, "normal"), { desc = "Send lines to Forth" })
vim.keymap.set("v", "<leader>;", wrap(send_lines_to_terminal, "visual"), { desc = "Send lines to Forth" })
