return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- local fg_color = '#a7c080'
    -- local b_bg_color = '#3c474d'
    -- local c_bg_color = '#4e585e'
    -- local noice = require('noice')

    local common_sections = {
      lualine_a = { 'mode' },
      lualine_b = { { 'branch', icon = { '', align = 'right', } } },
      lualine_c = { 'diff', 'diagnostics', 'filename' },
      lualine_x = {
        'selectioncount',
        -- {
        --   noice.api.status.search.get,
        --   cond = noice.api.status.search.has,
        --   color = { fg = fg_color },
        -- },
        -- {
        --   noice.api.status.command.get,
        --   cond = noice.api.status.command.has,
        --   color = { fg = fg_color },
        -- },
      },
      lualine_y = { 'filetype', 'encoding', 'fileformat' },
      lualine_z = {
        {
          'location',
          color = { fg = '#FFFFFF', bg = '#D25858' },
          fmt = function(ln_col)
            local col = ln_col:match(':(%d+)')
            return string.format('%03d', col) -- 3 digits zero-padded
          end,
        }
      },
    }

    require('lualine').setup({
      options = {
        section_separators = { '', '' },
        component_separators = { '', '' },
        theme = 'everforest',
      },
      sections = common_sections,
      inactive_sections = common_sections,
    })
  end,
  event = 'UIEnter', -- aiming for faster startup time
  -- event = 'VimEnter', -- loaded just before `UIEnter` (`VimEnter`) for "instant" impact on UI perceived performance
}
