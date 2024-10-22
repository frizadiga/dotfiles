return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      winopts = {
				preview = {
					border = "rounded",
					style = "minimal",
					position = "bottom",
					-- position = "right",
					layout = "vertical",
				},
			},
		})

		-- :lua require('fzf-lua').files({ fzf_opts = {['--layout'] = 'reverse-list'} })
		vim.api.nvim_set_keymap('n', '<leader>fz',
			"<cmd>lua require('fzf-lua').files({ fzf_opts = {['--layout'] = 'reverse-list'} })<CR>",
			{ noremap = true, silent = true }
		)
  end
}
