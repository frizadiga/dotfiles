return {
  {
    'hrsh7th/cmp-cmdline',
    event = 'VimEnter',
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter', -- https://github.com/nvim-lua/kickstart.nvim/blob/2ba39c69736597b60f6033aa3f8526e7c28343d5/init.lua#L722
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp'
      },
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          'saadparwaiz1/cmp_luasnip',
          'rafamadriz/friendly-snippets',
        },
      },
    },
    config = function()
      local cmp = require('cmp')
      require('luasnip.loaders.from_vscode').lazy_load()

      -- base cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        -- sources = cmp.config.sources(
        --   {
        --     { name = 'nvim_lsp' },
        --     { name = 'luasnip' }, -- for luasnip users.
        --     { name = 'path' },
        --     { name = 'buffer' },
        --   }
        -- ),
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- for luasnip users.
          { name = 'path' },
          { name = 'buffer' },
        },
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
            {
              name = 'cmdline',
              option = {
                ignore_cmds = { 'Man', '!' }
              }
            }
          })
      })
    end,
  },
}
