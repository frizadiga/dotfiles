return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },
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

    -- search notification history
    vim.keymap.set('n', '<leader>nn', '<CMD>Noice telescope<CR>', { desc = 'Show Last Notification' })
  end,
}
