return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      'fzf-native', -- profile
      -- 'telescope', -- profile
      files = {
        prompt = '▶ ',
        cwd_prompt = false,
        fzf_opts = {
          ['--layout'] = 'default',
        },
      },
      winopts = {
        -- window layout
        fullscreen = true,
        -- height     = 0.8,
        -- width      = 80,
        -- Position the results in the middle
        row     = 0.35,
        col     = 0.50,
        -- border style
        border     = 'none',
        preview    = {
          vertical   = 'up:65%',   -- Preview window on top
          horizontal = 'right:50%', -- For horizontal preview
          layout     = 'vertical',
          flip_columns = 120,
        },
      },
    })

    -- navigate on result using <CTRL> + hjkl keys

    vim.api.nvim_set_keymap('n', '<leader>fz',
      -- "<cmd>lua require('fzf-lua').files({ fzf_opts = {['--layout'] = 'reverse-list'} })<CR>",
      "<cmd>lua require('fzf-lua').files()<CR>",
      { noremap = true, silent = true }
    )
  end
}
