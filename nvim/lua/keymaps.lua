-- keymaps configurations

-- esc composite
vim.keymap.set("i", "kj", "<Esc>", {})

-- local search/find 
-- vim.api.nvim_set_keymap("n","<leader>s",":/", {}) -- conflict with spectre

-- clear search highlight
-- vim.api.nvim_set_keymap("n","<leader>cs",":nohlsearch<CR>", { noremap = true })

-- quit 
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

-- fzf
-- vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Fzf Files" })
-- Or, with args
-- vim.keymap.set("n", "<c-P>", function() require('fzf-lua').files({ ... }) end, { desc = "Fzf Files" })

-- write 
vim.api.nvim_set_keymap("n","<Space><Space>",":w<CR>", { noremap = true, silent = true })

-- replace 
vim.api.nvim_set_keymap("n","<leader>r",":%s//g<Left><Left>", { noremap = true, silent = true })

-- copy selected text to search input when pressing `/`
vim.keymap.set('v', '/', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { noremap = true, silent = true })

