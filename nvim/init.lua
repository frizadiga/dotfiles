local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("vim-opt")
require("keymaps")

-- Lazy setup
require("lazy").setup("plugins", {
	install = { colorscheme = { "kanagawa-dragon" } },
	ui = {
		pills = true, size = { width = 1, height = 1 }, border = "single", checker = { enabled = true },
  }
})

