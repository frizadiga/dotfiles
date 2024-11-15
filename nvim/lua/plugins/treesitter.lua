return {
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
