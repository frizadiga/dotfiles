return {
  {
    -- treesitter based
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    build = ':TSUpdate',
    config = function()
      local config = require('nvim-treesitter.configs')
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        -- context_commentstring = '',
        context_commentstring = { enable = true, enable_autocmd = false },
      })
    end
  }
}
