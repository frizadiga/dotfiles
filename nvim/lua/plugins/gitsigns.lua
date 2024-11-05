return {
  'lewis6991/gitsigns.nvim',
  config  = function()
    require('gitsigns').setup{
      diff_opts = {
        vertical = false,
      },
    }
    -- show diff
    vim.api.nvim_set_keymap('n',
      '<leader>gd',
      '<CMD>lua require("gitsigns").diffthis()<CR>',
      { noremap = true, silent = true }
    )
    -- preview hunk
    vim.api.nvim_set_keymap('n',
      '<leader>gp',
      '<CMD>lua require("gitsigns").preview_hunk()<CR>',
      { noremap = true, silent = true }
    )
    -- blame line
    vim.api.nvim_set_keymap('n',
      '<leader>gb',
      '<CMD>lua require("gitsigns").blame_line{full=false}<CR>',
      { noremap = true, silent = true }
    )
    -- toggle signs
    vim.api.nvim_set_keymap('n', '<leader>gh', '<CMD>Gitsigns toggle_signs<CR>', { noremap = true, silent = true })
  end,
}

