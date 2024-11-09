-- generic keymaps
-- see: https://neovim.io/doc/user/map.html or `:help map`

-- composite escape
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('v', 'KJ', '<Esc>')

-- quit
vim.keymap.set('n', '<leader>qq', '<CMD>q<CR>')

-- write
vim.keymap.set('n', '<Space><Space>', '<CMD>w<CR>')

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

-- toggle between tabs and spaces
vim.keymap.set('n', '<leader>tt', function()
  if vim.opt_local.expandtab:get() then
    vim.opt_local.expandtab = false
    print('Using tabs')
  else
    vim.opt_local.expandtab = true
    print('Using spaces')
  end
end, { desc = 'Toggle tabs/spaces' })

-- fix/adjust indentation for entire file
vim.keymap.set('n', '<leader>i', 'gg=G<C-o>', { desc = 'Fix indentation for entire file' })
-- @end indentation

-- add workspace folder
-- vim.keymap.set('n', '<leader>awf', vim.lsp.buf.add_workspace_folder)
