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

			-- Ruby
      -- lspconfig.solargraph.setup({
      --   capabilities = capabilities
      -- })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "<leader>gn", vim.lsp.buf.rename, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
