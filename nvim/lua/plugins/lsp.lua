return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")

      -- C/C++
      lspconfig.clangd.setup({
        capabilities = capabilities,
      })

			-- Bash
			lspconfig.bashls.setup({
				capabilities = capabilities
			})

      -- Go
      lspconfig.gopls.setup({
        capabilities = capabilities,
      })

			-- JavaScript/TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })

			-- HTML
      lspconfig.html.setup({
        capabilities = capabilities
      })

			-- Lua
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

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {})
    end,
  },
}
