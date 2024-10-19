return {
  "shortcuts/no-neck-pain.nvim",
  config = function()
    require("no-neck-pain").setup({
      -- width = 62,
      -- width = 82,
			buffers = {
				colors = {
					blend = 0,
				},
			}
    })

    vim.keymap.set("n", "<leader>n", ":NoNeckPain<CR>", { noremap = true, silent = true })
  end,
}
