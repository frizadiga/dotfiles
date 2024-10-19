return {
  "zbirenbaum/copilot-cmp",
  config = function()
    require("copilot_cmp").setup({
      sources = {
        -- Copilot Source
        { name = "copilot", group_index = 2 },
        -- Other Sources
        { name = "nvim_lsp", group_index = 2 },
        { name = "path", group_index = 2 },
        { name = "luasnip", group_index = 2 },
      },
      -- formatting = {
      --   format = lspkind.cmp_format({
      --     mode = "symbol",
      --     max_width = 50,
      --     symbol_map = { Copilot = "" }
      --   })
      -- }
    })
  end,
}