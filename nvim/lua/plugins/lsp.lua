return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason').setup({
        ui = {
          width = 1,
          height = 1,
          border = 'none',
          check_outdated_packages_on_open = true,
        },
        ensure_installed = { 'eslint_d' },
      })
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    event = 'VeryLazy',
    opts = {
      auto_install = true,
      ensure_installed = {
        'bashls',
        'clangd',
        'zls',
        'gopls',
        'html',
        'ts_ls',
        'jsonls',
        'lua_ls',
        'pyright',
        'rust_analyzer',
        -- 'mojo-lsp-server', -- for now manually install, isn't avail via mason yet
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    config = function()
      local lspconfig = require 'lspconfig'
      local lspconfig_util = require 'lspconfig.util'
      -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- capabilities.textDocument.formatting = true
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local get_git_root = function(fname)
        return lspconfig_util.root_pattern '.git' (fname)
      end

      -- c/c++
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

      -- zig
      lspconfig.zls.setup({
        capabilities = capabilities,
      })

      -- rust
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })

      -- bash
      lspconfig.bashls.setup({
        capabilities = capabilities
      })

      -- go
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

      -- javascript/typescript
      lspconfig.ts_ls.setup({
        root_dir = get_git_root,
        capabilities = capabilities
      })

      -- eslint
      lspconfig.eslint.setup({
        root_dir = get_git_root,
        capabilities = capabilities
      })

      -- json
      lspconfig.jsonls.setup({
        capabilities = capabilities
      })

      -- html
      lspconfig.html.setup({
        capabilities = capabilities
      })

      -- python
      lspconfig.pyright.setup({
        capabilities = capabilities
      })

      -- lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- @ARCHIVED:
            -- diagnostics = {
            --   globals = { 'vim', 'hs', 'ui' }, -- use .luarc.json instead
            --   disable = { 'missing-fields' }
            -- },
            -- workspace = {
            --   -- tell lua_ls to use .luarc.json from the project directory
            --   checkThirdParty = false,
            --   library = {
            --     vim.fn.expand('$VIMRUNTIME/lua'),
            --     vim.fn.stdpath('config') .. '/lua'
            --   }
            -- },
          }
        },
        capabilities = capabilities,
      })

      -- mojo
      lspconfig.mojo.setup({
        capabilities = capabilities,
        cmd = { 'mojo-lsp-server' },
        filetypes = { 'mojo', '🔥' },
      })

      -- more lsp see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP: Hover' })
      vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, { desc = 'LSP: Do Format - Current Buffer' })
      vim.keymap.set('x', '<leader>lf', vim.lsp.buf.format, { desc = 'LSP: Do Format - Selected Visual Text' })
      vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, { desc = 'LSP: Do Rename' })
      vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, { desc = 'LSP: Go to Definition' })
      vim.keymap.set('n', '<leader>lD', vim.lsp.buf.declaration, { desc = 'LSP: Go to Declaration' })
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, { desc = 'LSP: Go to References' })
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { desc = 'LSP: Select Code Action' })
      vim.keymap.set('n', '<leader>lc', vim.diagnostic.reset, { desc = 'LSP: Clear all Diagnostics in the current buffer' })
    end,
  },
}
