return {
  'MagicDuck/grug-far.nvim',
  event = 'VeryLazy',
  config = function()
    local grug = require 'grug-far'

    grug.setup({
      -- options, see Configuration section below
      -- there are no required options atm
      -- engine = 'ripgrep' is default, but 'astgrep' can be specified
      startInInsertMode = false,
      windowCreationCommand = 'new', -- new | enew | split
      disableBufferLineNumbers = false, -- if `enew` -> false to prevent line numbers issue
      -- help line config
      helpLine = {
        -- whether to show the help line at the top of the buffer
        enabled = false,
      },
      -- separator between inputs and results, default depends on nerdfont
      resultsSeparatorLineChar = '·',
      keymaps = {
        -- @NOTES: localLeader = ',',
        -- Default keymaps:
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
        -- applyNext = { n = '<localleader>j' },
        -- applyPrev = { n = '<localleader>k' },
        -- Custom keymaps:
        qflist = { n = 'qq' },
        historyOpen = { n = 'H' },
      },
      openTargetWindow = {
        preferredLocation = 'below',
      },
      previewWindow = {
        height = 25,
      },
      helpWindow = {
        height = vim.o.lines,
      },
      historyWindow = {
        height = vim.o.lines,
      },
      icons = {
        enabled = true,
        searchInput = '     ',
        replaceInput = '     ',
        filesFilterInput = '     ',
        flagsInput = '    󰮚 ',
        pathsInput = '     ',
        resultsEngineLeft = '⚙️',
        resultsEngineRight = '',
      },
    });

    vim.keymap.set('x', '<leader>ss', function()
      grug.open({
        prefills = {
          search = vim.fn.expand('<cword>')
        }
      })
    end, { desc = 'Grug: Search with current selection' })
    vim.keymap.set('n', '<leader>ss', '<CMD>GrugFar<CR>', { desc = 'Grug: Open new search buffer' })
  end
}
