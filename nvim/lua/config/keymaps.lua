-- global keymaps

-- add workspace folder
-- vim.keymap.set("n", "<leader>awf", vim.lsp.buf.add_workspace_folder)

-- esc composite
vim.keymap.set("i", "kj", "<Esc>", {})
vim.keymap.set("v", "KJ", "<Esc>", {})

-- quit
vim.keymap.set("n", "<leader>qq", "<CMD>q<CR>")

-- copy to clipboard current file path
vim.keymap.set(
  "n",
  "<leader>cp",
  "<CMD>let @+=expand('%:p')<CR>:echo 'Copied: ' . expand('%:p')<CR>"
)

-- write
vim.keymap.set("n", "<Space><Space>", "<CMD>w<CR>")

-- replace
vim.keymap.set("n", "<leader>r", ":%s//g<Left><Left>")
-- in visual mode prefill search with selected text
vim.keymap.set("v", "<leader>r", ":s/<C-r><C-w>//g<Left><Left>")

-- copy selected text to search input when pressing `/`
vim.keymap.set('v', '/', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])

-- start indentation
-- basic indentation
vim.keymap.set('v', '<', '<gv')      -- Indent left in visual mode and stay in visual mode
vim.keymap.set('v', '>', '>gv')      -- Indent right in visual mode and stay in visual mode
vim.keymap.set('n', '<Tab>', '>>')   -- Indent right in normal mode
vim.keymap.set('n', '<S-Tab>', '<<') -- Indent left in normal mode

-- fix/adjust indentation
vim.keymap.set('n', '<leader>i', 'gg=G<C-o>', { desc = 'Fix indentation for entire file' })

-- auto indent when pasting
vim.keymap.set('n', 'p', ']p', { desc = 'Paste with auto-indent' })
vim.keymap.set('n', 'P', '[p', { desc = 'Paste with auto-indent (before cursor)' })

-- format specific lines
vim.keymap.set('n', '=', '==', { desc = 'Fix indentation for current line' })
vim.keymap.set('n', '<leader>il', 'V=', { desc = 'Fix indentation for current line (alternative)' })

-- visual mode specific
vim.keymap.set('v', '=', '=', { desc = 'Fix indentation for selected lines' })

-- optional: auto format on save for specific filetypes
-- vim.api.nvim_create_autocmd("BufWritePre", {
-- 	pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.py", "*.lua" },
-- 	callback = function()
-- 		vim.lsp.buf.format()
-- 	end,
-- })

-- optional: toggle between tabs and spaces
-- vim.keymap.set('n', '<leader>tt', function()
--   if vim.opt_local.expandtab:get() then
--     vim.opt_local.expandtab = false
--     print('Using tabs')
--   else
--     vim.opt_local.expandtab = true
--     print('Using spaces')
--   end
-- end, { desc = 'Toggle tabs/spaces' })
-- end indentation
