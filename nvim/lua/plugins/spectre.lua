return {
  'nvim-pack/nvim-spectre',
  keys = {
    '<leader>ss',
    '<leader>sp',
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

    -- path: custom working directory
    vim.keymap.set('n', '<leader>sp',
      function()
        -- @TODO: look for current buffer dir first
        local search = vim.fn.input('Search Path > ')
        spectre.open({ cwd = search })
      end,
      { desc = 'Spectre: custom path' }
    )

    -- path: project root
    vim.keymap.set('n', '<leader>ss', function() spectre.toggle() end, { desc = 'Spectre: toggle' })

    -- path: project root - prefill with selected text
    vim.keymap.set('v', '<leader>ss', function() spectre.open_visual() end, { desc = 'Spectre: visual mode' })
  end,
}
