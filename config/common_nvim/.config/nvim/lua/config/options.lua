-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
vim.opt.relativenumber = false
vim.g.autoformat = false

vim.g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}

local opt = vim.opt
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

vim.keymap.set("n", "<Leader>py", "<Cmd>!python %<CR>", { buffer = true, desc = ":!python %" })
vim.keymap.set("n", "<Leader>pe", "<Cmd>!pipenv run python %<CR>", { buffer = true, desc = ":!pipenv run python %" })
vim.keymap.set("n", "<Leader>pi", function()
  vim.cmd(string.format([[TermExec cmd="python %s"]], vim.fn.expand("%:~:.")))
end, { buffer = true, desc = "[ToggleTerm] python %" })

