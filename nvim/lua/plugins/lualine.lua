return {
  'nvim-lualine/lualine.nvim',
  config = function()
    -- local fg_color = '#a7c080'
    -- local noice = require('noice')

    local common_sections = {
      lualine_a = { 'mode' },
      lualine_b = {{ 'branch', icon = { '', align='right', }}},
      lualine_c = { 'filename', 'diff', 'diagnostics' },
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
      lualine_y = { 'location' },
      lualine_z = { 'fileformat' },
      -- lualine_z = { { 'location', color = { bg = '#9c3333' } } },
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
  event = 'VimEnter', -- must be loaded just before `UIEnter` (`VimEnter`) for "instant" impact on UI perceived performance
}
