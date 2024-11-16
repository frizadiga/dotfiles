return {
  {
    'hrsh7th/cmp-cmdline',
    event = 'CmdlineEnter',
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'hrsh7th/cmp-nvim-lsp'
      },
      {
        'hrsh7th/cmp-path'
      },
      {
        'hrsh7th/cmp-buffer'
      },
      {
        'saadparwaiz1/cmp_luasnip',
        after = 'L3MON4D3/LuaSnip',
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
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- for luasnip users.
          { name = 'path' },
          { name = 'buffer' },
        },
      })

      -- `/` cmdline search.
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline command.
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
