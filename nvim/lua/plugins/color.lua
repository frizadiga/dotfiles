-- return {}

return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  name = "kanagawa",
  priority = 1000,
  config = function()
    require('kanagawa').setup({
      compile = false,             -- enable compiling the colorscheme
      undercurl = true,            -- enable undercurls
      commentStyle = { italic = false },
      functionStyle = {},
      keywordStyle = { italic = false},
      statementStyle = { bold = true },
      typeStyle = {},
      transparent = true,         -- do not set background color
      dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
      terminalColors = true,       -- define vim.g.terminal_color_{0,17}
      colors = {                   -- add/modify theme and palette colors
          palette = {},
          theme = {
            wave = {},
            lotus = {},
            dragon = {},
            all = {
              ui = { bg_gutter = "none", float = { bg = "none" } }
            }
          },
      },
      overrides = function(colors) -- add/modify highlights
          -- return {
          --   -- telescope border
          --   TelescopeBorder = { fg = "none", bg = "none" },
          -- }
        local theme = colors.theme
        return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            -- Save an hlgroup with dark background and dimmed foreground
            -- so that you can use it where your still want darker windows.
            -- E.g.: autocmd TermOpen * setlocal winhighlight=Normal:NormalDark
            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            -- Popular plugins that open floats will link to NormalFloat by default;
            -- set their background accordingly if you wish to keep them dark and borderless
            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            -- telescope border
            TelescopeBorder = { fg = "none", bg = "none" },
        }
      end,
      -- theme = "dragon",              -- Load "wave" theme when 'background' option is not set
      -- background = {               -- map the value of 'background' option to a theme
      --     dark = "dragon",           -- try "dragon" !
      --     light = "lotus"
      -- },
  })

  -- setup must be called before loading
  vim.cmd("colorscheme kanagawa-dragon")
  end
}

-- return {
--   {
--     "catppuccin/nvim",
--     lazy = false,
--     name = "catppuccin",
--     priority = 1000,
--     config = function()
--       vim.cmd.colorscheme "catppuccin-mocha"
--     end
--   }
-- }

-- return {
--   {
--     "ellisonleao/gruvbox.nvim",
--     lazy = false,
--     name = "gruvbox",
--     priority = 1000,
--     config = function()
--       require("gruvbox").setup({
--         terminal_colors = true, -- add neovim terminal colors
--         undercurl = true,
--         underline = true,
--         bold = true,
--         italic = {
--           strings = true,
--           emphasis = true,
--           comments = true,
--           operators = false,
--           folds = true,
--         },
--         strikethrough = true,
--         invert_selection = false,
--         invert_signs = false,
--         invert_tabline = false,
--         invert_intend_guides = false,
--         inverse = true, -- invert background for search, diffs, statuslines and errors
--         contrast = "", -- can be "hard", "soft" or empty string
--         palette_overrides = {},
--         overrides = {},
--         dim_inactive = false,
--         transparent_mode = false,
--       })
--       vim.cmd("colorscheme gruvbox")
--     end,
--     -- opts = { transparent_mode = true },
--   }
-- }
