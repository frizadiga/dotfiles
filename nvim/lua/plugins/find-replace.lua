return {
  'nvim-pack/nvim-spectre',
  keys = {
    '<leader>ss',
    '<leader>sp',
    '<leader>sw',
    '<leader>sf',
  },
  config = function()
    require('spectre').setup({
      open_cmd = 'enew',
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = { '-i', '', '-E' },
        }, -- handle -E prefix files see: https://github.com/nvim-pack/nvim-spectre/issues/118#issuecomment-1531683211
      },
    })

    vim.keymap.set('n', '<leader>ss',
      '<CMD>lua require("spectre").toggle()<CR>', {
        desc = 'Toggle Spectre'
      })
    -- open in custom search path
    vim.keymap.set('n', '<leader>sp', function()
      local search = vim.fn.input('Search Path > ')
      require('spectre').open({cwd = search})
    end, {desc = 'Search on custom path'})
    vim.keymap.set('n', '<leader>sw', '<CMD>lua require("spectre").open_visual({select_word=true})<CR>', {
      desc = 'Search current word'
    })
    vim.keymap.set('v', '<leader>sw', '<esc><CMD>lua require("spectre").open_visual()<CR>', {
      desc = 'Search current word'
    })
    vim.keymap.set('n', '<leader>sf', '<CMD>lua require("spectre").open_file_search({select_word=true})<CR>', {
      desc = 'Search on current file'
    })
  end,
}

-- return {
-- 	'MagicDuck/grug-far.nvim',
-- 	config = function()
-- 		require('grug-far').setup({
-- 			-- options, see Configuration section below
-- 			-- there are no required options atm
-- 			-- engine = 'ripgrep' is default, but 'astgrep' can be specified
-- 			startInInsertMode = false,
-- 			windowCreationCommand = 'enew', -- enew | split
-- 			disableBufferLineNumbers = false,
--       -- help line config
-- 			helpLine = {
-- 				-- whether to show the help line at the top of the buffer
-- 				enabled = false,
-- 			},
-- 		  -- separator between inputs and results, default depends on nerdfont
-- 			resultsSeparatorLineChar = '·',
-- 			keymaps = {
-- 				-- replace = { n = '<localleader>r' },
-- 				-- qflist = { n = '<localleader>q' },
-- 				-- syncLocations = { n = '<localleader>s' },
-- 				-- syncLine = { n = '<localleader>l' },
-- 				-- close = { n = '<localleader>c' },
-- 				-- historyOpen = { n = '<localleader>t' },
-- 				-- historyAdd = { n = '<localleader>a' },
-- 				-- refresh = { n = '<localleader>f' },
-- 				-- openLocation = { n = '<localleader>o' },
-- 				-- openNextLocation = { n = '<down>' },
-- 				-- openPrevLocation = { n = '<up>' },
-- 				-- gotoLocation = { n = '<enter>' },
-- 				-- pickHistoryEntry = { n = '<enter>' },
-- 				-- abort = { n = '<localleader>b' },
-- 				-- help = { n = 'g?' },
-- 				-- toggleShowCommand = { n = '<localleader>p' },
-- 				-- swapEngine = { n = '<localleader>e' },
-- 				-- previewLocation = { n = '<localleader>i' },
-- 				-- swapReplacementInterpreter = { n = '<localleader>x' },
-- 				previewLocation = { n = '<enter>' },
-- 			},
-- 			icons = {
--         enabled = true,
--         actionEntryBullet = '',
--         -- actionEntryBullet = '•',
-- 				searchInput = '     ',
-- 				replaceInput = '     ',
-- 				filesFilterInput = '     ',
-- 				flagsInput = '    󰮚 ',
-- 				pathsInput = '    / ',
-- 			  resultsEngineLeft = '',
--         resultsEngineRight = '',
-- 			},
-- 		});
-- 		-- require('grug-far').open(opts)
--   	vim.keymap.set('n', '<leader>ss', '<CMD>GrugFar<CR>', {
--   		desc = "Toggle Grug"
-- 		})
-- 		-- :lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
-- 		vim.keymap.set('v', '<leader>sw', '<CMD>lua require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })<CR>', {
-- 				desc = "Search current word"
-- 		})
-- 		-- auto close
-- 		-- vim.api.nvim_create_autocmd('FileType', {
-- 		-- 	group = vim.api.nvim_create_augroup('grug-far-keybindings', { clear = true }),
-- 		-- 	pattern = { 'grug-far' },
-- 		-- 	callback = function()
-- 		-- 		vim.api.nvim_buf_set_keymap(0, 'n', '<C-enter>', '<localleader>o<localleader>c', {})
-- 		-- 	end,
-- 		-- })
-- 	end
-- }
--
