-- generic keymaps
-- see: https://neovim.io/doc/user/map.html or `:help map`

-- composite escape
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('v', 'KJ', '<Esc>')

-- quit
vim.keymap.set('n', '<leader>qq', '<CMD>q<CR>')

-- close current buffer
vim.keymap.set('n', '<leader>w', '<CMD>bd<CR>')

-- write to fs if only buffer is modified
vim.keymap.set('n', '<Space><Space>', '<CMD>update<CR>')

-- find
-- copy selected text to search input when pressing `/`
vim.keymap.set('v', '/', [[y/\V<C-R>=escape(@", '/\')<CR><CR>]])

-- replace
vim.keymap.set('n', '<leader>r', ':%s//g<Left><Left>')
-- in visual mode prefill search with selected text
vim.keymap.set('v', '<leader>r', ':s/<C-r><C-w>//g<Left><Left>')

-- copy to clipboard current file path
vim.keymap.set(
  'n',
  '<leader>cp',
  '<CMD>let @+=expand("%:p")<CR>:echo "Copied: " .. expand("%:p")<CR>'
)

-- move selected block up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- @start indentation
-- basic indentation
vim.keymap.set('n', '<Tab>', '>>')   -- Indent right in normal mode
vim.keymap.set('n', '<S-Tab>', '<<') -- Indent left in normal mode
vim.keymap.set('v', '<', '<gv')      -- Indent left in visual mode and stay in visual mode
vim.keymap.set('v', '>', '>gv')      -- Indent right in visual mode and stay in visual mode

-- auto indent when pasting
vim.keymap.set('n', 'p', ']p', { desc = 'Paste with auto-indent' })
vim.keymap.set('n', 'P', '[p', { desc = 'Paste with auto-indent (before cursor)' })

-- format specific lines
vim.keymap.set('n', '=', '==', { desc = 'Fix indentation for current line' })

-- visual mode specific
vim.keymap.set('v', '=', '=', { desc = 'Fix indentation for selected lines' })

-- fix/adjust indentation for entire file
vim.keymap.set('n', '<leader>i', 'gg=G<C-o>', { desc = 'Fix indentation for entire file' })
-- @end indentation

-- add workspace folder
-- vim.keymap.set('n', '<leader>awf', vim.lsp.buf.add_workspace_folder)
