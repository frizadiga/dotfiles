return {
  'lewis6991/gitsigns.nvim',
  opts = {},
  keys = {
    { '<leader>gb', function()
      require('gitsigns').blame_line{full=false}
    end, desc = 'Git blame line' },
  },
}

