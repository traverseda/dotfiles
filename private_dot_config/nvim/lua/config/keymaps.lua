-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps herec-- Move to window using the <ctrl> hjkl keys
-- This file is automatically loaded by lazyvim.config.init
local map = vim.keymap.set

--- Maps that should work inside and outside a terminal
for _, s in ipairs({ "n", "t" }) do
  map(s, "<C-a>c", "<cmd>:term<cr>", { desc = "Open new terminal", noremap = true })
  map(s, "<C-a>x", "<cmd>:bd<cr>", { desc = "Close tab", noremap = true })
  map(s, "<C-a>s", "<cmd>:BufferLinePick<CR>", { desc = "Pick buffer", noremap = true })
end
