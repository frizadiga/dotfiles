return {
  'nvim-pack/nvim-spectre',
  keys = {
    '<leader>ss',
    '<leader>sp',
    '<leader>sw',
    '<leader>sf',
  },
  config = function()
    local spectre = require('spectre')

    spectre.setup({
      open_cmd = 'enew',
      replace_engine = {
        ['sed'] = {
          cmd = 'sed',
          args = { '-i', '', '-E' }, -- fix unwanted "*-E" files 
        },
      },
    })

    -- path: project root
    vim.keymap.set('n', '<leader>ss',
      function ()
        spectre.toggle()
      end,
      { desc = 'Spectre: toggle' }
    )

    -- path: custom working directory
    vim.keymap.set('n', '<leader>sp',
      function()
        local search = vim.fn.input('Search Path > ')
        spectre.open({cwd = search})
      end,
      { desc = 'Spectre: custom path' }
    )

    vim.keymap.set('n', '<leader>sw',
      function()
        spectre.open_visual({ select_word = true })
        -- '<CMD>lua require("spectre").open_visual({select_word=true})<CR>'
      end,
      { desc = 'Spectre: current word' }
    )

    vim.keymap.set('n', '<leader>sf',
      function()
        spectre.open_file_search({ select_word = true })
        -- '<CMD>lua require("spectre").open_file_search({select_word=true})<CR>'
      end,
      { desc = 'Spectre: current file' }
    )

    vim.keymap.set('v', '<leader>sw', '<esc><CMD>lua require("spectre").open_visual()<CR>', { desc = 'Spectre: current word' })
  end,
}
