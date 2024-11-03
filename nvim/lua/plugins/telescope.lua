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
					prompt_prefix = ' ▶ ',
					-- prompt_prefix = ' ▶ ⇢ ',
          selection_caret = '·',
          -- selection_caret = '⇢ ',
          -- selection_caret = '▸ ',
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
			local default_opts = { noremap = true, silent = true }

		  -- find files
			-- vim.api.nvim_set_keymap('n', ';',
			-- 	":lua require'telescope.builtin'.find_files({ hidden = true })<CR>",
			-- default_opts)
			--    vim.api.nvim_set_keymap('n', '<leader>ff',
			-- 	":lua require'telescope.builtin'.find_files({ hidden = true })<CR>",
			-- default_opts)
			local find_files_keymaps = { ';', '<leader>ff' }
			for _, key in ipairs(find_files_keymaps) do
				vim.api.nvim_set_keymap(
					'n', key, ":lua require'telescope.builtin'.find_files({ hidden = true })<CR>", default_opts
				)
			end

			-- grep_string
			vim.keymap.set('n', '<leader>fs', function()
				builtin.grep_string({ search = vim.fn.input("Grep > ")})
			end, { desc = 'Telescope Grep string' })

			-- marks
			vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope Marks' })

			-- buffers
			local action_state = require('telescope.actions.state')
			local actions = require('telescope.actions')

			Buffer_searcher = function()
					builtin.buffers {
							sort_mru = true,
							ignore_current_buffer = true,
							show_all_buffers = false,
							attach_mappings = function(prompt_bufnr, map)
									local refresh_buffer_searcher = function()
											actions.close(prompt_bufnr)
											vim.schedule(Buffer_searcher)
									end

									local delete_buf = function()
											local selection = action_state.get_selected_entry()
											vim.api.nvim_buf_delete(selection.bufnr, { force = true })
											refresh_buffer_searcher()
									end

									local delete_multiple_buf = function()
											local picker = action_state.get_current_picker(prompt_bufnr)
											local selection = picker:get_multi_selection()
											for _, entry in ipairs(selection) do
													vim.api.nvim_buf_delete(entry.bufnr, { force = true })
											end
											refresh_buffer_searcher()
									end

									map('n', 'dd', delete_buf)
									map('n', '<C-d>', delete_multiple_buf)
									map('i', '<C-d>', delete_multiple_buf)

									return true
							end
					}
			end

			-- vim.keymap.set('n', "'", Buffer_searcher, {})
			-- vim.keymap.set('n', '<leader>fb', Buffer_searcher, {})
			local buffer_keymaps = { "'", '<leader>fb' }
			for _, key in ipairs(buffer_keymaps) do
				vim.api.nvim_set_keymap(
					'n', key, ":lua Buffer_searcher()<CR>", default_opts
				)
			end
			-- vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope Buffers' })

			-- live_grep
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live grep' })
			vim.api.nvim_set_keymap('v', '<leader>fg', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', default_opts)

      require('telescope').load_extension('ui-select')
			require('telescope').load_extension('fzf') -- #performance improvement
    end,
  },
}
