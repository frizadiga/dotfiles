return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  dependencies = { 'MunifTanjim/nui.nvim' },
  config = function()
    require('noice').setup({
      views = {
        mini = {
          win_options = {
            winblend = 0 -- fix lsp notif blocking the screen (case: rust-analyzer)
          }
        },
      }
    })

    -- show last notification
    vim.keymap.set('n', '<leader>nl', '<CMD>Noice last<CR>', { desc = 'Show Last Notification' })

    -- search notification history
    vim.keymap.set('n', '<leader>nn', '<CMD>Noice telescope<CR>', { desc = 'Show Notification History' })
  end,
}
