return {
  'jackMort/ChatGPT.nvim',
	event = 'VeryLazy',
	config = function()
		require('chatgpt').setup({
      popup_layout = {
      default = "center",
      center = {
        width = "80",
        height = "80%",
      },
    }})

		-- show the chatgpt prompt
  	vim.keymap.set('n', '<leader>cg', '<CMD>ChatGPT<CR>', { desc = 'ChatGPT floating prompt' })

	end,
	dependencies = {
		'MunifTanjim/nui.nvim',
		'nvim-lua/plenary.nvim',
		'folke/trouble.nvim', -- optional
		'nvim-telescope/telescope.nvim'
	}
}
