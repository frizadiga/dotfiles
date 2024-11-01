return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local oil = require("oil")
    oil.setup({
		  -- See :help oil-columns
			columns = {
				"icon",
				-- "permissions",
				-- "size",
				-- "mtime",
			},
			view_options = {
			  -- Show files and directories that start with "."
				show_hidden = true,
				-- This function defines what is considered a "hidden" file
				is_hidden_file = function(name)
					return vim.startswith(name, ".")
				end,
			},
      preview = {
        win_options = {
          winhl = "Normal:Normal,Float:Float",
        },
      },
      -- Configuration for the floating window in oil.open_float
      float = {
        -- Padding around the floating window
        padding = 2,
        max_width = 55,
        max_height = 25,
        border = "rounded",
				-- make title empty to disable the title
				get_win_title = function() return "" end,
      },
  	  default_file_explorer = false, -- prevent oil startup screen passing `false` is required
  })
		-- Open floating window
    vim.keymap.set("n", "e", oil.toggle_float, {})

		-- Open Oil in the path it was opened with `nvim .`
		-- vim.keymap.set("n", "<leader>e", "<CMD>Oil .<CR>", { desc = "Open Oil in current directory" })
		vim.keymap.set("n", "<leader>e", "<CMD>Oil --float .<CR>", { desc = "Open Oil in current directory" })

		-- Close the Oil buffer with ESC, only react to ESC in oil buffers
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'oil',
			callback = function()
				vim.api.nvim_buf_set_keymap(0, 'n', '<Esc>', '<CMD>lua require("oil").close()<CR>', { noremap = true, silent = true })
			end,
		})
  end,
}
