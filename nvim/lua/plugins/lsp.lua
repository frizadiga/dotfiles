return {
  {
    'williamboman/mason.nvim',
    event = 'VeryLazy',
    config = function()
      require('mason').setup({
        ui = {
          width = 1,
          height = 1,
          border = 'single',
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
        'lua_ls',
        'rust_analyzer',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    event = 'VeryLazy',
    config = function()
      local lspconfig = require('lspconfig')
      local lspconfig_util = require 'lspconfig.util'
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local get_git_root = function(fname)
        return lspconfig_util.root_pattern '.git'(fname)
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

      -- html
      lspconfig.html.setup({
        capabilities = capabilities
      })

      -- lua
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'}
            }
          }
        },
        capabilities = capabilities,
      })

      -- mojo:
      -- @TODO: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#mojo

      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>ln', vim.lsp.buf.rename, {})
      vim.keymap.set('n', '<leader>ld', vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>lr', vim.lsp.buf.references, {})
      vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>lc', vim.diagnostic.reset, {}) -- clear diagnostics sign in current buffer
    end,
  },
}
