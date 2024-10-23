return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('telescope').setup({
        defaults = {
					preview = {
            timeout = 150, -- ms #performance improvement
            filesize_limit = 1, -- MB #performance improvement
					},
					path_display = {
						'truncate',
					},
					prompt_prefix = ' ▶ ⇢ ',
          selection_caret = '▸ ',
          layout_strategy = 'vertical',
          layout_config = {
            vertical = { width = 80, preview_cutoff = 0 },
          },
					cache_picker = {
						num_pickers = 5, -- #performance improvement
						limit_entries = 1000 -- #performance improvement
					},
					file_ignore_patterns = {"%.git/", "node_modules/"}, -- #performance improvement
        },
        -- other configuration values here
				pickers = {
					find_files = {
						follow = true,
						find_command = {'fd', '--type', 'f', '--strip-cwd-prefix'} -- #performance improvement
					},
					-- live_grep = {
					-- 	follow = true
					-- },
				},
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown({}),
          },
        },
      })

      local builtin = require('telescope.builtin')

		  -- find files
      vim.api.nvim_set_keymap('n', '<leader>ff',
				":lua require'telescope.builtin'.find_files({ hidden = true })<CR>", {
				noremap = true, silent = true
			})

			-- marks
			vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope Marks' })

			-- buffers
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Buffers' })

			-- live grep
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live grep' })

      require('telescope').load_extension('ui-select')
			require('telescope').load_extension('fzf') -- #performance improvement
    end,
  },
}
