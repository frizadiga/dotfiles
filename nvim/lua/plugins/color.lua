return {
  'rebelot/kanagawa.nvim',
  lazy = false,
  name = 'kanagawa',
  priority = 1000,
  config = function()
    require('kanagawa').setup({
      -- 1. Modify your config
      -- 2. Restart nvim
      -- 3. Run this command:
      -- :KanagawaCompile
      compile = true,  -- enable compiling the colorscheme
      undercurl = true,  -- enable undercurls
      commentStyle = { italic = false },
      keywordStyle = { italic = false},
      statementStyle = { bold = true },
      transparent = true,  -- do not set background color
      dimInactive = false,  -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,  -- define vim.g.terminal_color_{0,17}
      colors = {  -- add/modify theme and palette colors
        theme = {
          all = {
            ui = { bg_gutter = 'none', float = { bg = 'none' } }
          }
        },
      },
      overrides = function()
        -- get `colors` from function arg
        -- local theme = colors.theme
        -- Save an hlgroup with dark background and dimmed foreground
        -- so that you can use it where your still want darker windows.
        -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
        -- NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

        -- Popular plugins that open floats will link to NormalFloat by default;
        -- set their background accordingly if you wish to keep them dark and borderless
        -- LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        -- MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

        return {
          Visual = { bg = '#3E4451' },
          NormalFloat = { bg = 'none' },
          FloatBorder = { bg = 'none' },
          FloatTitle = { bg = 'none' },
          TelescopeBorder = { fg = 'none', bg = 'none' },
          TelescopePromptPrefix = { fg = '#D75F00', bg = 'none' },
          TelescopeSelectionCaret = { fg = '#393836', bg = '#393836' }, -- hlgroup: `CursorLine`
        }
      end,
    })

    -- setup must be called before loading
    vim.cmd('colorscheme kanagawa-dragon')
  end
}
