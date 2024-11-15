return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module='...'` entries
    -- 'MunifTanjim/nui.nvim',
    { "MunifTanjim/nui.nvim", lazy = true }
  },
  config = function()
    require('noice').setup({
      views = {
        mini = {
          win_options = {
            winblend = 0
          }
        },
      }
    })

    -- search message history
    vim.keymap.set('n', '<leader>nn', '<CMD>Noice telescope<CR>', { desc = "Show Last Message" })
  end,
}
