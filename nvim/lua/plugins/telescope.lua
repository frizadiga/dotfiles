return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x', -- stable
  -- branch = 'master', -- latest (currently still broken)
  dependencies = {
    'nvim-telescope/telescope-ui-select.nvim', -- for lsp code actions
    {
      -- c implementation of fzf sorter for telescope
      -- benchmark: https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      -- build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
    },
  },
  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')
    local action_state = require('telescope.actions.state')
    local utils = require('telescope.utils')
    local builtin = require('telescope.builtin')

    local use_cwd = false -- flag to use current buffer dir as cwd

    -- fn: find grep string from visual mode
    local function find_grep_string()
      vim.cmd('normal! y') -- copy visual selection to clipboard
      local selection_text = vim.fn.getreg('0'):gsub('[\n\r]', '') -- get most recently yanked value and rm newlines
      builtin.grep_string({ search = selection_text })
    end

    -- fn: construct final search query
    local function get_search_query()
      local search_query = action_state.get_current_line()
      return search_query:gsub(';$', '') -- remove trailing ; (not found trigger symbol)
    end

    -- @start_section oldfiles + fzf files
    -- usecase: 
    -- 1. open telescope oldfiles
    -- 2. find a file
    -- 3. if no files found, press enter to open fzf files

    local function fzf_files_open()
      local search_query = get_search_query()

      vim.defer_fn(function()
        require('fzf-lua').files({
          query = search_query,
          cwd = use_cwd and utils.buffer_dir() or nil,
          -- force cursor to input prompt
          winopts = {
            on_create = function()
              -- move cursor to the prompt line
              vim.cmd('startinsert!')
            end
          }
        })
      end, 1) -- delay in ms to ensure the cursor is focus in the prompt
    end

    local function find_files(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      if #picker:get_multi_selection() == 0 and picker:get_selection(prompt_bufnr) == nil then
        actions.close(prompt_bufnr)
        fzf_files_open()
      else
        actions.select_default(prompt_bufnr)
      end
    end
    -- @end_section oldfiles + fzf files

    -- @start_section live grep + fzf live grep native
    -- usecase:
    -- 1. open telescope live grep
    -- 2. find a pattern
    -- 3. if no pattern found, press enter to open fzf live grep native

    local function fzf_live_grep_native_open()
      local search_query = get_search_query()

      vim.defer_fn(function()
        require('fzf-lua').live_grep_native({
          query = search_query,
          cwd = use_cwd and utils.buffer_dir() or nil,
          -- force cursor to input prompt
          winopts = {
            on_create = function()
              -- move cursor to the prompt line
              vim.cmd('startinsert!')
            end
          }
        })
      end, 1) -- delay in ms to ensure the cursor is focus in the prompt
    end

    local function find_live_grep(prompt_bufnr)
      local picker = action_state.get_current_picker(prompt_bufnr)
      if #picker:get_multi_selection() == 0 and picker:get_selection(prompt_bufnr) == nil then
        actions.close(prompt_bufnr)
        fzf_live_grep_native_open()
      else
        actions.select_default(prompt_bufnr)
      end
    end
    -- @end_section live grep + fzf live grep native

    telescope.setup({
      -- @start_section default
      defaults = {
        mappings = {
          i = {
            ['<esc>'] = actions.close,
          },
          n = {
            ['q'] = actions.close,
            ['KJ'] = actions.close,
            ['H'] = actions.cycle_history_prev,
            ['L'] = actions.cycle_history_next,
            -- set as enter
            [';'] = actions.select_default,
          },
        },
        preview = {
          timeout = 50, -- ms #performance improvement
          filesize_limit = 1, -- MB #performance improvement
        },
        path_display = { 'truncate' },
        prompt_prefix = ' ▶ ',
        -- selection_caret = '·',
        layout_strategy = 'vertical',
        layout_config = {
          vertical = {
            width = 80,
            height = 0.9,
            preview_height = 0.6, -- fraction of total height
            -- preview_cutoff = 40, -- when columns are less than this value, the preview will be disabled
          },
        },
        cache_picker = {
          num_pickers = 5, -- #performance improvement
          limit_entries = 1000, -- #performance improvement
        },
        file_ignore_patterns = {"%.git/", "node_modules/"}, -- #performance improvement
      },
      -- @end_section default

      -- @start_section pickers
      pickers = {
        oldfiles = {
          prompt_title = 'Files - Recent',
          mappings = {
            i = { ['<CR>'] = find_files },
            n = { ['<CR>'] = find_files },
          },
          cwd_only = true, -- prevent list files globally across all projects
        },

        live_grep = {
          follow = true,
          prompt_title = 'Live Grep - Entire Project',
          find_command = {
            'rg', '--hidden', '--files', '--no-ignore-vcs', '--no-ignore',
            '--follow', '--hidden', '--glob', '!.git', '--glob', '!node_modules'
          }, -- #performance improvement
          mappings = { i = { ['<CR>'] = find_live_grep } },
        },

        find_files = {
          follow = true,
          mappings = { i = { ['<CR>'] = find_files } },
          prompt_title = '[DONT - USE OLDFILES INSTEAD] - Find Files - Entire Project',
          find_command = {'fd', '--type', 'f', '--strip-cwd-prefix'}, -- #performance improvement
        },
      },
      -- @end_section pickers

      -- @start_section extensions
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown({
            layout_config = {
              -- center = { width = 50 },
              prompt_position = 'bottom',
            },
            -- layout_strategy = 'bottom_pane',
          }),
        },
      },
      -- @end_section extensions
    })

    -- find recently opened files
    vim.keymap.set('n', ';', function()
      use_cwd = false
      builtin.oldfiles()
    end, { desc = 'Telescope: Oldfiles (Recent Files)' })

    -- find recently opened files -- visual mode
    vim.keymap.set('v', ';', function()
      use_cwd = false
      vim.cmd('normal! y') -- copy visual selection to clipboard
      local selection_text = vim.fn.getreg('0'):gsub('[\n\r]', '') -- remove newlines
      builtin.oldfiles({ default_text = selection_text })
    end, { desc = 'Telescope: Oldfiles (Recent Files) - visual mode' })

    -- find files active buffer dir
    vim.keymap.set('n', '<leader>:', function()
      use_cwd = true
      builtin.find_files({ cwd = utils.buffer_dir(), prompt_title = 'Find Files - CWD' })
    end, { desc = 'Telescope: Find files cwd' })

    -- grep_string
    vim.keymap.set('n', '<leader>f/', function()
      builtin.grep_string({ search = vim.fn.input("Grep")})
    end, { desc = 'Telescope: Grep string' })

    -- grep string - visual mode
    vim.keymap.set('v', '<leader>f/', find_grep_string, { desc = 'Telescope: Grep string - visual mode' })

    -- live_grep active buffer dir
    vim.keymap.set('n', '<leader>fc', function()
      use_cwd = true
      builtin.live_grep({ prompt_title = 'Live Grep - CWD', cwd = utils.buffer_dir() })
    end, { desc = 'Telescope: Live grep - cwd' })

    -- live_grep entire project
    vim.keymap.set('n', '<leader>ff', function()
      use_cwd = false
      builtin.live_grep({ prompt_title = 'Live Grep - Entire Project' })
    end, { desc = 'Telescope: Live grep - entire project' })
    -- vim.keymap.set('v', '<leader>ff', 'y<ESC>:Telescope live_grep default_text=<C-r>0<CR>')
    vim.keymap.set('v', '<leader>ff', find_grep_string, { desc = 'Telescope: Live grep - visual mode' })

    -- buffers
    local finder_buf = require('shared.finder_buffers')
    vim.keymap.set('n', "'", function() finder_buf.GLOBAL_finder_buf() end)

    -- resume
    vim.keymap.set('n', '<leader>;', builtin.resume, { desc = 'Telescope: Resume' })

    -- builtins
    vim.keymap.set('n', '<leader>fl', builtin.builtin, { desc = 'Telescope: Builtin' })

    -- marks
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope: Marks' })

    -- LSP symbols
    vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope: LSP Symbols' })

    -- diagnostic (current buffer)
    vim.keymap.set('n', '<leader>fd', function()
      builtin.diagnostics({ bufnr = 0 })
    end, { desc = 'Telescope: LSP diagnostics current buffer' })

    -- diagnostics (workspace scopes)
    vim.keymap.set('n', '<leader>fD', builtin.diagnostics, { desc = 'Telescope: LSP diagnostics (workspace)' })

    -- use telescope extensions if installed
    pcall(telescope.load_extension, 'fzf')
    pcall(telescope.load_extension, 'ui-select')
  end,
}
