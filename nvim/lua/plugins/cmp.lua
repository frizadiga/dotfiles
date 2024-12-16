return {
  {
    'hrsh7th/cmp-cmdline',
    event = 'CmdlineEnter',
  },
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      {
        'saadparwaiz1/cmp_luasnip',
        after = 'L3MON4D3/LuaSnip',
      },
      {
        'L3MON4D3/LuaSnip',
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    see the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

      luasnip.config.setup {}

      -- base cmp setup
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          -- accept ([y]es) the completion.
          -- auto-import if your LSP supports it.
          -- expand snippets if the LSP sent a snippet.
          ['<CR>'] = cmp.mapping.confirm { select = true },
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- prevent conflict with copilot <Tab>
          ['<S-Tab>'] = cmp.mapping.select_next_item(),

          -- scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- manually trigger a completion from nvim-cmp.
          -- generally you don't need this, because nvim-cmp will display
          -- completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- think of <c-l> as moving to the right of your snippet expansion.
          -- so if you have a snippet that's like:
          -- function $name($args)
          --   $body
          -- end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- advanced Luasnip keymaps (e.g. selecting choice nodes, expansion)
          -- see: https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        }),
        sources = {
          { name = "path", group_index = 2 },
          { name = "buffer", group_index = 2 },
          { name = "luasnip", group_index = 2 },
          { name = "copilot", group_index = 2 },
          { name = "nvim_lsp", group_index = 2 },
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
