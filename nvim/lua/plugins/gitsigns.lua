return {
    'lewis6991/gitsigns.nvim',
    opts = {},  -- if you don't need custom setup
    keys = {
        { '<leader>gb', function()
            require('gitsigns').blame_line{full=true}
        end, desc = 'Git blame line' },
    },
}

