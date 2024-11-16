-- shared plugins
return {
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    -- treesitter based
    'folke/ts-comments.nvim',
    opts = {},
    event = 'VeryLazy',
    enabled = vim.fn.has('nvim-0.10.0') == 1,
  },
  { 'nvim-tree/nvim-web-devicons', event = 'VeryLazy' },
}
