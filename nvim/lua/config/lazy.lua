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
    -- load from dir /plugins
    { import = 'plugins' },
  },
  install = { colorscheme = { 'kanagawa-dragon' } },
  -- automatically check for plugin updates
  checker = { enabled = true },
  ui = {
    pills = false, size = { width = 1, height = 1 }, border = 'single',
  }
})

