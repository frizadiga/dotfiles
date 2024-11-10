-- vim options
-- see: https://neovim.io/doc/user/options.html or `:help options`

-- @start startup screen
-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- disable default intro
vim.opt.shortmess:append('I')
-- @end startup screen

-- sign column
vim.wo.signcolumn = 'yes' -- (why? prevent layout shift)

-- set autoread
vim.opt.autoread = true

-- set mapleader to space
vim.g.mapleader = ' '
vim.g.maplocalleader = ',' -- Same for `maplocalleader`
-- vim.g.maplocalleader = '\\' -- Same for `maplocalleader`

-- @start cursor
-- hide GUI cursor
-- vim.opt.guicursor = ''
-- change cursor type on diff mode
-- docs: https://neovim.io/doc/user/options.html#'guicursor'
vim.opt.guicursor = 'n-v-c-sm:block,i-ci-ve:hor100,r-cr-o:hor20'
-- vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'
-- @end cursor

-- show line numbers
vim.opt.rnu = true -- relative line numbers
vim.wo.number = false -- dont show absolute line numbers

-- set fill characters for end of buffer
vim.opt.fillchars = { eob = ' ' }

vim.opt.timeoutlen = 1000 -- default is 1000

-- use system clipboard
vim.opt.clipboard = 'unnamedplus'

-- set termgui colors
vim.opt.termguicolors = true

-- @start lsp
-- show lsp diagnostics on popup
-- ref: https://stackoverflow.com/a/70760302/6893303
vim.diagnostic.config({
	virtual_text = false
})

-- show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
-- @end lsp

-- @start indent
-- set tabstop and shiftwidth
vim.opt.expandtab = true -- Convert tabs to spaces
vim.opt.tabstop = 2      -- Default spaces for tab
vim.opt.softtabstop = 2  -- Default spaces when editing
vim.opt.shiftwidth = 2   -- Default spaces for auto indent

-- optional: add indent detection for better results
vim.g.detect_indent = true
vim.g.detect_indent_max_lines = 1000
-- @end indent

-- @start language config
vim.api.nvim_create_autocmd('FileType', {
	pattern = 'python',
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'javascript,typescript,javascriptreact,typescriptreact',
	callback = function()
		vim.opt_local.expandtab = true
		vim.opt_local.shiftwidth = 2
		vim.opt_local.tabstop = 2
		vim.opt_local.softtabstop = 2
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'go',
	callback = function()
		vim.opt_local.expandtab = false
		vim.opt_local.shiftwidth = 4
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
	end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c,cpp',
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.shiftwidth = 4
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- you can add more languages following the same pattern
-- @end language config

