return {
  'lewis6991/gitsigns.nvim',
  config  = function()
    require('gitsigns').setup{
      diff_opts = {
        vertical = false,
      },
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      -- doc: https://github.com/lewis6991/gitsigns.nvim/blob/4daf7022f1481edf1e8fb9947df13bb07c18e89a/lua/gitsigns/config.lua#L212
    }

    -- highlight group
    local function get_color(group, attr)
      local fn = vim.fn
      return fn.synIDattr(fn.synIDtrans(fn.hlID(group)), attr)
    end

    vim.api.nvim_set_hl(0, "GitSignsAddPreview", { fg = get_color("GitSignsAddPreview", "fg"), bg = "none" })
    vim.api.nvim_set_hl(0, "GitSignsDeletePreview", { fg = get_color("GitSignsDeletePreview", "fg"), bg = "none" })

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
    -- reset hunk
    vim.api.nvim_set_keymap('n',
      '<leader>gr',
      '<CMD>lua require("gitsigns").reset_hunk()<CR>',
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

