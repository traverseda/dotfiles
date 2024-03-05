local map = vim.keymap.set
for _, s in ipairs({ "n", "t" }) do
  map(s, "<C-a>c", "<cmd>:term<cr>", { desc = "Open new terminal", noremap = true })
  map(s, "<C-a>x", "<cmd>:bd<cr>", { desc = "Close tab", noremap = true })
  map(s, "<C-a>s", "<cmd>:BufferLinePick<CR>", { desc = "Pick buffer", noremap = true })
end

vim.api.nvim_set_keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { noremap = true })

