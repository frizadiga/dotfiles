return {
  'rebelot/kanagawa.nvim',
  event = 'UIEnter', -- it's ok cause we opened an empty buffer anw
  config = function()
    require('kanagawa').setup({
      -- 1. modify your config
      -- 2. restart nvim
      -- 3. run this command:
      -- :KanagawaCompile
      compile = false, -- somehow disabling it improves startup time
      undercurl = true,
      commentStyle = { italic = false },
      keywordStyle = { italic = false},
      statementStyle = { bold = true },
      transparent = true,  -- do not set background color
      dimInactive = false,  -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,  -- define vim.g.terminal_color_{0,17}
      colors = {
        theme = {
          all = {
            ui = { bg_gutter = 'none', float = { bg = 'none' } }
          }
        },
      },
      overrides = function()
        -- get `colors` from function arg
        -- local theme = colors.theme
        -- save an hlgroup with dark background and dimmed foreground
        -- so that you can use it where your still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        local ColorMainRed = '#D25858'
        local ColorSecondaryRed = '#9c3333'

        return {
          -- text styles
          ["@variable.builtin"] = { italic = false },

          -- highlight colors
          -- Visual = { bg = '#4f3333' },
          Visual = { fg = 'white', bg = ColorMainRed },
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatFooter = { bg = 'none' },
          FloatermBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          StatusLine = { bg = 'none' },
          StatusLineNC = { bg = 'none' },
          FzfLuaCursor = { fg = ColorMainRed },
          FzfLuaFzfPrompt = { fg = ColorMainRed },
          NotifyBackground = { bg = 'none' },
          MiniPickPrompt = { bg = 'none' },
          MiniTablineHidden = { bg = 'none' },
          MiniStatuslineFilename = { bg = 'none' },
          CopilotChatHeader = { fg = ColorSecondaryRed },
          CopilotChatSeparator = { fg = '#54546d', bg = 'none' },
          TelescopeBorder = { bg = 'none' },
          TelescopeMatching = { bg = ColorSecondaryRed },
          TelescopePromptPrefix = { fg = ColorMainRed, bg = 'none' },
          TelescopePromptNormal = { fg = ColorMainRed, bg = 'none' },
          TelescopeSelectionCaret = { fg = ColorSecondaryRed, bg = ColorSecondaryRed }, -- hlgroup: `CursorLine`
        }
      end,
    })

    -- setup must be called before loading
    vim.cmd('colorscheme kanagawa-dragon')
  end
}
