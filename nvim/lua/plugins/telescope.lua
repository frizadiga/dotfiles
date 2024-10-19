return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
					path_display = {
						"truncate",
					},
					prompt_prefix = " ▶ ⇢ ",
          selection_caret = "▸ ",
          layout_strategy = "vertical",
          layout_config = {
            vertical = { width = 80, preview_cutoff = 0 },
            -- other layout configuration here
          },
          -- other defaults configuration here
        },
        -- other configuration values here
          pickers = {
            find_files = {
              follow = true
            },
					  -- live_grep = {
						-- 	follow = true
						-- },
          },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })

      local builtin = require("telescope.builtin")

		  -- find files
      vim.api.nvim_set_keymap('n', '<leader>ff',
				':lua require"telescope.builtin".find_files({ hidden = true })<CR>', {
				noremap = true, silent = true
			})

			-- marks
			vim.keymap.set("n", "<leader>fm", builtin.marks, { desc = "Telescope Marks" })

			-- buffers
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope Buffers" })

			-- live grep
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope Live grep" })

      require("telescope").load_extension("ui-select")
    end,
  },
}
