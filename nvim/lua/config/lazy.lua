-- lazy loading recipes:
-- https://lazy.folke.io/spec/examples
-- https://lazy.folke.io/spec/lazy_loading
-- https://www.lazyvim.org/configuration/lazy.nvim -- yes it's a distro but it has some great tips

-- start bootstrap lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      {('Failed to clone lazy.nvim:\n'),'ErrorMsg'},
      {out,'WarningMsg'},{'\nPress any key to exit...'}},
      true, {}
    )
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
-- end bootstrap lazy.nvim

-- vim options
require('config.vim') -- make sure loaded before lazy plugins setup

-- keybindings
require('config.keymaps') -- make sure loaded before lazy plugins setup

-- lazy plugins setup
require('lazy').setup({
  spec = {
    { import = 'plugins' }, -- load from dir /plugins
  },
  install = { colorscheme = { 'kanagawa-dragon' } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- it saves about 20ms on startup
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = {
    pills = false, size = { width = 1, height = 1 }, border = 'single',
  },
  defaults = {
    lazy = true, -- @NOTES: disabled auto lazy loading when shit happen 
  },
  -- see: https://github.com/folke/lazy.nvim/blob/main/lua/lazy/core/config.lua
})

