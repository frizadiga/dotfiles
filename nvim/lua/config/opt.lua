-- vim options
-- see: https://neovim.io/doc/user/options.html or `:help options`

-- @start_section startup screen
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable default intro
vim.opt.shortmess:append('I')
-- @end_section startup screen

-- @start_section shell
-- set shell to zsh
vim.opt.shell = '/bin/zsh'
-- @end_section shell

-- @start_section shared data
-- :lua print(vim.opt.shada._value)
-- {{!,'100,<50,s10,h}}
-- ! - save global variables
-- '100 - save marks
-- <50 - save 50 lines of command line history
-- s10 - save 10 items in search history
-- h - save 20 lines of command line history
vim.opt.shada = "!,'50,<50,s10,h"
-- vim.opt.shada = "!,'30,f1,<50,s10,h"
-- vim.opt.shada = "!,'100,<50,s10,h" -- default value as of Neovim 0.10
-- @end_section shared data

-- disable swap files
vim.opt.swapfile = false

-- sign column
vim.wo.signcolumn = 'yes' -- (why? prevent layout shift)

-- set autoread
vim.opt.autoread = true -- sync external files changes

-- set mapleader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ',' -- Same for `maplocalleader`
-- vim.g.maplocalleader = '\\' -- Same for `maplocalleader`

-- @start_section cursor
-- change cursor type on diff mode
-- docs: https://neovim.io/doc/user/options.html#'guicursor'
-- what does this do?
-- 1. normal mode: block
-- 2. insert mode: horizontal line
-- 3. visual mode: vertical line
-- 4. replace mode: horizontal line
-- 5. command mode: horizontal line
-- 6. operator pending mode: horizontal line
-- 7. terminal mode: block
-- 8. prompt mode: horizontal line
-- 9. select mode: vertical line
vim.opt.guicursor = 'n-c-sm:block,i-ci-ve:hor100,v:hor100,r-cr-o:hor100'
-- @end_section cursor

-- show line numbers
vim.opt.rnu = true -- relative line numbers
vim.wo.number = false -- dont show absolute line numbers

-- set fill characters for end of buffer
vim.opt.fillchars = { eob = ' ' }

-- set listchars
vim.opt.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·', extends = '>', precedes = '<', nbsp = '␣' }

vim.opt.timeoutlen = 1000 -- default is 1000
vim.opt.updatetime = 4000 -- default is 4000

-- use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- set term colors
vim.cmd [[
  highlight Normal guibg=NONE
  highlight Normal ctermbg=NONE
  highlight NonText guibg=NONE
  highlight NonText ctermbg=NONE
]]
vim.opt.termguicolors = true

-- @start lsp
-- show lsp diagnostics on popup
-- ref: https://stackoverflow.com/a/70760302/6893303
vim.diagnostic.config({
  virtual_text = false
})

-- show line diagnostics automatically in hover window
vim.opt.updatetime = 250 -- default: 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- @end lsp

-- @start_section indent
-- set tabstop and shiftwidth
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2      -- Default spaces for tab
vim.opt.softtabstop = 2  -- Default spaces when editing
vim.opt.shiftwidth = 2   -- Default spaces for auto indent

-- optional: add indent detection for better results
vim.g.detect_indent = true
vim.g.detect_indent_max_lines = 1000
-- @end_section indent
