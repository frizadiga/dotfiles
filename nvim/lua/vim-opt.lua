-- main settings

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set autoread
vim.opt.autoread = true

-- set mapleader to space
vim.g.mapleader = " "
vim.g.maplocalleader = "," -- Same for `maplocalleader`
-- vim.g.maplocalleader = "\\" -- Same for `maplocalleader`

-- cursor
-- hide GUI cursor
-- vim.opt.guicursor = ""
-- change cursor type on diff mode
-- docs: https://neovim.io/doc/user/options.html#'guicursor'
vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:hor100,r-cr-o:hor20"
-- vim.o.guicursor = 'n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor'

-- show line numbers
vim.opt.rnu = true

-- set fill characters for end of buffer
vim.opt.fillchars = { eob = ' ' }

-- set tabstop and shiftwidth
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- disable highlight search
-- vim.opt.hlsearch = false

vim.opt.timeoutlen = 1000 -- default is 1000

-- transparent popup border
vim.api.nvim_set_hl(0, "NormalFloat", {bg="#3B4252"})


-- status bar color to transparent
vim.cmd('hi StatusLine ctermbg=235 cterm=NONE')

-- use system clipboard
vim.opt.clipboard = "unnamedplus"

-- set termgui colors
vim.opt.termguicolors = true
-- vim.api.nvim_set_hl(0, 'NormalFloat', {fg = LightGrey})
-- vim.api.nvim_set_hl(0, "TelescopeBorder", {bg="#ffffff", fg="#ffffff"})

vim.keymap.set("n", "<leader>awf", vim.lsp.buf.add_workspace_folder)

-- show lsp diagnostics on popup
-- ref: https://stackoverflow.com/a/70760302/6893303
vim.diagnostic.config({
  virtual_text = false
})
-- show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- sign column
vim.wo.signcolumn = "yes"

-- code folding
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldlevel = 99
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

