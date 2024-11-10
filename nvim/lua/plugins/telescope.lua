return {
  {
    'nvim-telescope/telescope-ui-select.nvim',
  },
  {
    -- c implementation of fzf sorter for telescope
    -- benchmark: https://github.com/nvim-telescope/telescope.nvim/wiki/Extensions
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release'
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local actions = require("telescope.actions")

      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ['<esc>'] = actions.close,
            },
            n = {
              ['q'] = actions.close,
              ['KJ'] = actions.close,
            },
          },
          preview = {
            timeout = 150, -- ms #performance improvement
            filesize_limit = 1, -- MB #performance improvement
          },
          path_display = {
            'truncate',
          },
          prompt_prefix = ' ▶ ',
          selection_caret = '·',
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

      -- resume
      local resume_keymaps = { 'f', '<leader>fr' }
      for _, key in ipairs(resume_keymaps) do
        vim.keymap.set(
          'n', key, "<CMD>lua require'telescope.builtin'.resume()<CR>",
          { noremap = true, silent = true, desc = 'Telescope Resume' }
        )
      end

      -- builtin list
      vim.keymap.set('n', '<leader>fl', builtin.builtin, { desc = 'Telescope Builtin' })

      -- find files
      local find_files_keymaps = { ';', '<leader>ff' }
      for _, key in ipairs(find_files_keymaps) do
        vim.keymap.set(
          'n', key, ":lua require'telescope.builtin'.find_files({ hidden = true })<CR>",
          { noremap = true, silent = true, desc = 'Telescope Find files' }
        )
      end

      -- grep_string
      vim.keymap.set('n', '<leader>f/', function()
        builtin.grep_string({ search = vim.fn.input("Grep > ")})
      end, { desc = 'Telescope Grep string' })

      -- live_grep
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope Live grep' })
      vim.keymap.set('v', '<leader>fg', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>')

      -- buffers
      local action_state = require('telescope.actions.state')

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

      -- keymaps
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Telescope Keymaps' })

      -- commands
      vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Telescope Commands' })

      -- diagnostics
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope LSP diagnostics' })

      -- LSP symbols
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, { desc = 'Telescope LSP Symbols' })

      -- highlights groups
      vim.keymap.set('n', '<leader>fh', builtin.highlights, { desc = 'Telescope Highlights' })

      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('fzf') -- #performance improvement
    end,
  },
}
