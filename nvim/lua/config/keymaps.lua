-- keymaps configurations

-- add workspace folder
-- vim.keymap.set("n", "<leader>awf", vim.lsp.buf.add_workspace_folder)

-- local search/find 
-- vim.api.nvim_set_keymap("n","<leader>s","<cmd>/", {}) -- conflict with spectre

-- clear search highlight
-- vim.api.nvim_set_keymap("n","<leader>cs","<cmd>nohlsearch<CR>", { noremap = true })

-- vim.keymap.set("n", "<leader>awf", vim.lsp.buf.add_workspace_folder)

-- fzf
-- vim.keymap.set("n", "<c-P>", require('fzf-lua').files, { desc = "Fzf Files" })
-- Or, with args
-- vim.keymap.set("n", "<c-P>", function() require('fzf-lua').files({ ... }) end, { desc = "Fzf Files" })

-- esc composite
vim.keymap.set("i", "kj", "<Esc>", {})

-- quit 
vim.api.nvim_set_keymap("n","<leader>qq","<cmd>q<CR>", { noremap = true })

-- copy to clipboard current file path
vim.api.nvim_set_keymap(
  "n",
  "<leader>cp",
  "<cmd>let @+=expand('%:p')<CR>:echo 'Copied: ' . expand('%:p')<CR>",
  { noremap = true }
)

-- write 
vim.api.nvim_set_keymap("n","<Space><Space>","<cmd>w<CR>", { noremap = true, silent = true })

-- replace 
vim.api.nvim_set_keymap("n","<leader>r",":%s//g<Left><Left>", { noremap = true, silent = true })
-- in visual mode prefill search with selected text
vim.api.nvim_set_keymap("v","<leader>r",":s/<C-r><C-w>//g<Left><Left>", { noremap = true, silent = true })

-- copy selected text to search input when pressing `/`
vim.keymap.set('v', '/', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]], { noremap = true, silent = true })

