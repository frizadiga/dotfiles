-- return {
--   'nvim-pack/nvim-spectre',
--   config = function()
-- 		require('lua.plugins.find-replace').setup({
-- 			open_cmd = 'enew',
-- 		})
--
-- 		vim.keymap.set('n', '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>', {
--     desc = "Toggle Spectre"
-- 		})
-- 		vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
-- 				desc = "Search current word"
-- 		})
-- 		vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
-- 				desc = "Search current word"
-- 		})
-- 		vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
-- 				desc = "Search on current file"
-- 		})
-- 	end,
-- }

return {
	'MagicDuck/grug-far.nvim',
	config = function()
		require('grug-far').setup({
			windowCreationCommand = 'enew',
			-- windowCreationCommand = 'split',
			-- options, see Configuration section below
			-- there are no required options atm
			-- engine = 'ripgrep' is default, but 'astgrep' can be specified
			keymaps = {
				-- replace = { n = '<localleader>r' },
				-- qflist = { n = '<localleader>q' },
				-- syncLocations = { n = '<localleader>s' },
				-- syncLine = { n = '<localleader>l' },
				-- close = { n = '<localleader>c' },
				-- historyOpen = { n = '<localleader>t' },
				-- historyAdd = { n = '<localleader>a' },
				-- refresh = { n = '<localleader>f' },
				-- openLocation = { n = '<localleader>o' },
				-- openNextLocation = { n = '<down>' },
				-- openPrevLocation = { n = '<up>' },
				-- gotoLocation = { n = '<enter>' },
				-- pickHistoryEntry = { n = '<enter>' },
				-- abort = { n = '<localleader>b' },
				-- help = { n = 'g?' },
				-- toggleShowCommand = { n = '<localleader>p' },
				-- swapEngine = { n = '<localleader>e' },
				-- previewLocation = { n = '<localleader>i' },
				-- swapReplacementInterpreter = { n = '<localleader>x' },
				previewLocation = { n = '<enter>' },
			},
			icons = {
         actionEntryBullet = '',
         -- actionEntryBullet = '•',
			},
		});
		-- require('grug-far').open(opts)
  	vim.keymap.set('n', '<leader>ss', '<cmd>GrugFar<CR>', {
  		desc = "Toggle Grug"
		})
		-- :lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
		vim.keymap.set('v', '<leader>sw', '<cmd>lua require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })<CR>', {
				desc = "Search current word"
		})
		-- grub-far
		vim.api.nvim_create_autocmd('FileType', {
			group = vim.api.nvim_create_augroup('grug-far-keybindings', { clear = true }),
			pattern = { 'grug-far' },
			callback = function()
				vim.api.nvim_buf_set_keymap(0, 'n', '<C-enter>', '<localleader>o<localleader>c', {})
			end,
		})
	end
}

