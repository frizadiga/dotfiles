return {
  'nvim-lualine/lualine.nvim',
  lazy = false,
  config = function()
    local common_sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
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
  priority = 9999, -- must be loaded early due to high impact on UI perceived performance
}
