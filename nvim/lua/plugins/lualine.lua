return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('lualine').setup({
      options = {
        section_separators = { '', '' },
        component_separators = { '', '' },
        theme = 'everforest', -- https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
      },
      -- tabline = {}, -- top bar
			sections = { -- bottom bar
				lualine_a = { 'mode' },
				lualine_b = { 'branch' },
				lualine_c = { 'filename' },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
			},
      inactive_sections = {
				lualine_a = { 'mode' },
				lualine_b = { 'branch' },
				lualine_c = { 'filename' },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
				lualine_y = { 'progress' },
				lualine_z = { 'location' },
      },
      extensions = { 'fugitive', 'nvim-tree' }
    })
  end
}
