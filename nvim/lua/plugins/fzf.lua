return {
  'ibhagwan/fzf-lua',
  event = 'VeryLazy',
  config = function()
    local fzf = require('fzf-lua')

    fzf.setup({
      'fzf-native', -- profile
      fzf_opts = {
        ['--color'] = 'prompt:160,pointer:160',
      },
      files = {
        prompt = '▶ ',
        cwd_prompt = false,
        fzf_opts = {
          ['--layout'] = 'default',
        },
      },
      grep = {
        fzf_opts = {
          ['--layout'] = 'default',
        },
      },
      winopts = {
        -- window layout
        fullscreen = true,
        -- height     = 0.8,
        -- width      = 80,
        -- position the results in the middle
        -- row     = 0.35,
        -- col     = 0.50,
        -- border style
        border     = 'none',
        preview    = {
          vertical   = 'up:65%',   -- preview window on top
          horizontal = 'right:50%', -- for horizontal preview
          layout     = 'vertical',
          flip_columns = 120,
        },
      },
    })

    -- navigate on result using <CTRL> + hjkl keys

    -- files search entire project
    vim.keymap.set('n', '<leader>fz', fzf.files, { desc = 'FZF: files' })

    -- live grep native entire project
    vim.keymap.set('n', '<leader>FF', function() fzf.live_grep_native({ resume = true }) end, { desc = 'FZF: live_grep_native' })
  end
}
