return {
  -- treesitter based
  'folke/ts-comments.nvim',
  opts = {},
  event = 'VeryLazy',
  enabled = vim.fn.has('nvim-0.10.0') == 1,
}

-- return {
--   'numToStr/Comment.nvim',
-- 	lazy = false,
--   config = function()
--     require('Comment').setup({
-- 			toggler = {
-- 				line = "gcc",
-- 				block = "gcb",
-- 			},
-- 		})
--   end,
-- }

-- return {
--   'echasnovski/mini.comment',
--   version = '*',
--   config = function()
--     require('mini.comment').setup()
--   end,
-- }
