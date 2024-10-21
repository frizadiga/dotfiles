-- keymaps configurations

-- esc composite
vim.keymap.set("i", "kj", "<Esc>", {})

-- local search/find alias
-- vim.api.nvim_set_keymap("n","<leader>s",":/", {}) -- conflict with spectre

-- clear search highlight
-- vim.api.nvim_set_keymap("n","<leader>cs",":nohlsearch<CR>", { noremap = true })

-- quit alias
vim.api.nvim_set_keymap("n","<leader>qq",":q<CR>", { noremap = true })
-- vim.api.nvim_set_keymap("n","<leader>q",":q<CR>", { noremap = true })

-- copy to clipboard current file path
vim.api.nvim_set_keymap(
  "n",
  "<leader>cp",
  ":let @+=expand('%:p')<CR>:echo 'Copied: ' . expand('%:p')<CR>",
  { noremap = true }
)

-- vim.keymap.set("n", "<leader>awf", vim.lsp.buf.add_workspace_folder)

-- find files
vim.api.nvim_set_keymap('n', ';',
	':lua require"telescope.builtin".find_files({ hidden = true })<CR>', {
	noremap = true, silent = true
})

-- buffers
-- vim.api.nvim_set_keymap('n', '<leader>;', ':Telescope buffers<CR>', { noremap = true, silent = true })

-- write alias
vim.api.nvim_set_keymap("n","<Space><Space>",":w<CR>", { noremap = true, silent = true })

