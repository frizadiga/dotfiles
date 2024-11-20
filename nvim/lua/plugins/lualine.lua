return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local fg_color = '#a7c080'
    local noice = require('noice')

    local common_sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },
      lualine_x = {
        {
          noice.api.status.search.get,
          cond = noice.api.status.search.has,
          color = { fg = fg_color },
        },
        {
          noice.api.status.command.get,
          cond = noice.api.status.command.has,
          color = { fg = fg_color },
        },
        'encoding', 'fileformat', 'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
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
  event = 'VimEnter', -- must be loaded just before `UIEnter` for "instant" impact on UI perceived performance
}
