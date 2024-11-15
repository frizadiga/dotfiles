return {
  'lewis6991/gitsigns.nvim',
  event = 'VeryLazy',
  config  = function()
    require('gitsigns').setup{
      diff_opts = {
        vertical = false,
      },
      preview_config = {
        border = 'rounded',
      },
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      -- doc: https://github.com/lewis6991/gitsigns.nvim/blob/master/lua/gitsigns/config.lua#L212
    }

    -- show diff
    vim.keymap.set('n',
      '<leader>gd',
      '<CMD>lua require("gitsigns").diffthis()<CR>',
      { desc = 'Show Diff' }
    )

    -- preview hunk
    vim.keymap.set('n',
      '<leader>gg',
      '<CMD>lua require("gitsigns").preview_hunk()<CR>',
      { desc = 'Preview Hunk' }
    )

    -- next hunk
    vim.keymap.set('n',
      '<leader>gn',
      '<CMD>lua require("gitsigns").next_hunk()<CR>',
      { desc = 'Next Hunk' }
    )

    -- prev hunk
    vim.keymap.set('n',
      '<leader>gp',
      '<CMD>lua require("gitsigns").prev_hunk()<CR>',
      { desc = 'Prev Hunk' }
    )

    -- reset hunk
    vim.keymap.set('n',
      '<leader>gr',
      '<CMD>lua require("gitsigns").reset_hunk()<CR>',
      { desc = 'Reset Hunk' }
    )

    -- blame line
    vim.keymap.set('n',
      '<leader>gb',
      '<CMD>lua require("gitsigns").blame_line{full=false}<CR>',
      { desc = 'Blame Line' }
    )

    -- toggle signs
    vim.keymap.set('n', '<leader>gh', '<CMD>Gitsigns toggle_signs<CR>', { noremap = true, silent = true })

    -- highlight group
    local function get_color(group, attr)
      local fn = vim.fn
      return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
    end

    vim.api.nvim_set_hl(0, 'GitSignsAddPreview', { fg = get_color('GitSignsAddPreview', 'fg'), bg = 'none' })
    vim.api.nvim_set_hl(0, 'GitSignsDeletePreview', { fg = get_color('GitSignsDeletePreview', 'fg'), bg = 'none' })
  end,
}

