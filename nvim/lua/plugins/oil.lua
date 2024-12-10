return {
  'stevearc/oil.nvim',
  event = 'VeryLazy',
  config = function()
    local oil = require('oil')
    local state_detail = false

    local keymaps = {
      ['gd'] = {
        desc = "Toggle file detail view",
        callback = function()
          state_detail = not state_detail
          if state_detail then
            oil.set_columns({
              "icon",
              "permissions",
              "size",
              "mtime"
            })
          else
            oil.set_columns({ "icon" })
          end
        end,
      },
      -- to cater specific muscle memory case
      ['<Esc>'] = {
        desc = "Close oil",
        callback = function() oil.close() end,
      },
      ['<C-f>'] = {
        desc = "Live grep in current working directory",
        callback = function()
          local path = oil.get_current_dir()
          local builtin = require('telescope.builtin')

          oil.close() -- need to close oil to prevent result from opening in oil buffer
          builtin.live_grep({ prompt_title = 'Live Grep - CWD', cwd = path })
        end,
      },
    }

    local def_opt = {
      keymaps = keymaps,
      columns = { 'icon' }, -- see :help oil-columns
      view_options = {
        -- show files and directories that start with '.'
        show_hidden = true,
        -- this function defines what is considered a 'hidden' file
        is_hidden_file = function(name)
          return vim.startswith(name, '.')
        end,
      },
      preview = {
        win_options = {
          winhl = 'Normal:Normal,Float:Float',
        },
      },
      float = {
        padding = 2,
        max_width = 50,
        max_height = 20,
        border = 'rounded',
        -- make title empty to disable the title
        get_win_title = function() return '' end,
      },
      default_file_explorer = false, -- prevent oil startup screen passing `false` is required
    }

    oil.setup(def_opt)

    -- open floating window
    vim.keymap.set('n', '<leader>e', oil.toggle_float, {})

    -- open `oil` with path was opened with `nvim .`
    vim.keymap.set('n', '<leader>E', '<CMD>Oil --float .<CR>', { desc = 'Open Oil in root project path' })
  end,
}
