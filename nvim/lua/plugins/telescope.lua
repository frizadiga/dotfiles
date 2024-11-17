return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x', -- stable
    -- branch = 'master', -- latest (currently still broken)
    priority = 500,
    dependencies = {
      {
        'nvim-telescope/telescope-ui-select.nvim',
      },
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

      -- usecase: 
      -- 1. open telescope oldfiles
      -- 2. find a file
      -- 3. if no files selected, press enter to open fzf files
      local function fzf_files_open()
        local search_term = action_state.get_current_line()

        vim.defer_fn(function()
          require('fzf-lua').files({
            query = search_term,
            -- force cursor to input prompt
            winopts = {
              on_create = function()
                -- move cursor to the prompt line
                vim.cmd('startinsert!')
              end
            }
          })
        end, 10) -- 10ms delay to ensure the cursor is focus in the prompt
      end

      telescope.setup({
        -- @start defaults section
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close,
            },
            n = {
              ['q'] = actions.close,
              ['KJ'] = actions.close,
              -- set as enter
              [';'] = actions.select_default,
            },
          },
          preview = {
            timeout = 150, -- ms #performance improvement
            filesize_limit = 1, -- MB #performance improvement
          },
          path_display = { 'truncate' },
          prompt_prefix = ' ▶ ',
          -- selection_caret = '·',
          layout_strategy = 'vertical',
          layout_config = {
            vertical = { width = 80, preview_cutoff = 5 },
          },
          cache_picker = {
            num_pickers = 5, -- #performance improvement
            limit_entries = 1000, -- #performance improvement
          },
          file_ignore_patterns = {"%.git/", "node_modules/"}, -- #performance improvement
        },
        -- @end defaults section

        -- @start pickers section
        pickers = {
          find_files = {
            follow = true,
            prompt_title = 'Find Files - Entire Project',
            find_command = {'fd', '--type', 'f', '--strip-cwd-prefix'}, -- #performance improvement
            live_grep = {
              follow = true,
              prompt_title = 'Live Grep - Entire Project',
            },
          },

          oldfiles = {
            prompt_title = 'Files - Recent',
            cwd_only = true, -- prevent list files globally across all projects
            mappings = {
              i = {
                ['<CR>'] = function(prompt_bufnr)
                  local picker = action_state.get_current_picker(prompt_bufnr)
                  if #picker:get_multi_selection() == 0 and picker:get_selection(prompt_bufnr) == nil then
                    actions.close(prompt_bufnr)
                    fzf_files_open()
                  else
                    actions.select_default(prompt_bufnr)
                  end
                end,
              },
            },
          },
        },
        -- @end pickers section

        -- @start extensions section
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
        -- @end extensions section
      })

      -- frecency files (oldfiles + frecency indexing)
      vim.keymap.set('n', ';', function()
        builtin.oldfiles()
      end, { desc = 'Telescope Oldfiles (Recent Files)' })

      -- find files active buffer dir
      vim.keymap.set('n', '<leader>:', function()
        builtin.find_files({ cwd = utils.buffer_dir(), prompt_title = 'Find Files - CWD' })
      end, { desc = 'Telescope Find files cwd' })

      -- grep_string
      vim.keymap.set('n', '<leader>f/', function()
        builtin.grep_string({ search = vim.fn.input("Grep")})
      end, { desc = 'Telescope Grep string' })

      -- live_grep active buffer dir
      vim.keymap.set('n', '<leader>fc', function()
        builtin.live_grep({ prompt_title = 'Live Grep - CWD', cwd = utils.buffer_dir() })
      end, { desc = 'Telescope Live grep - cwd' })

      -- live_grep entire project
      vim.keymap.set('n', '<leader>ff', function()
        builtin.live_grep({ prompt_title = 'Live Grep - Entire Project' })
      end, { desc = 'Telescope Live grep - entire project' })
      vim.keymap.set('v', '<leader>ff', 'y<ESC>:Telescope live_grep default_text=<C-r>0<CR>')

      -- buffers
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

      local buffer_keymaps = { "'", '<leader>fb' }
      for _, key in ipairs(buffer_keymaps) do
        vim.keymap.set('n', key, ":lua Buffer_searcher()<CR>")
      end

      -- marks
      vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = 'Telescope Marks' })

      -- diagnostics
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope LSP diagnostics' })

      -- LSP symbols
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope LSP Symbols' })

      -- builtin list
      vim.keymap.set('n', '<leader>fl', builtin.builtin, { desc = 'Telescope Builtin' })

      -- resume
      local resume_keymaps = { 'f', '<leader>fr' }
      for _, key in ipairs(resume_keymaps) do
        vim.keymap.set(
          'n', key, "<CMD>lua require'telescope.builtin'.resume()<CR>",
          { noremap = true, silent = true, desc = 'Telescope Resume' }
        )
      end

      -- use telescope extensions if installed
      pcall(telescope.load_extension, 'fzf')
      pcall(telescope.load_extension, 'ui-select')
    end,
  },
}
