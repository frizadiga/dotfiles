return {
  'github/copilot.vim',
  -- 	'zbirenbaum/copilot.lua',
  -- 	cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   config = function()
  --     require('copilot').setup({})
  --   end,
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'github/copilot.vim' },
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
      -- { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
    },
    build = 'make tiktoken', -- Only on MacOS or Linux
    -- see commands section for default commands if you want to lazy load on them
    config = function()
      require('CopilotChat').setup({
        debug = false, -- enable debugging
        -- see configuration section for rest
        -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/canary/lua/CopilotChat/config.lua#L81
        mappings = {
          complete = {
            insert ='<S-Tab>',
            detail = 'Use @<Tab> or /<Tab> for options.',
            -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/324#issuecomment-2118551487
          },
          accept_diff = {
            normal = '<Space><Space>',
            insert = '<Space><Space>',
          },
          reset = {
            normal = '<C-l>',
            insert = '<C-l>',
          },
        },
        window = {
          title = '',
          layout = 'float', -- horizontal, vertical, float, replace,
          relative = 'win', -- 'editor', 'win', 'cursor', 'mouse'
          border = 'single', -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow',
          width = 0.6, -- fractional width of parent, or absolute width in columns when > 1
          height = 0.6, -- fractional height of parent, or absolute height in rows when > 1
        }
      })
      -- CopilotChatToggle
      vim.keymap.set('n', '<leader>ccc', '<CMD>CopilotChatToggle<CR>')
      vim.keymap.set('v', '<leader>ccc', '<CMD>CopilotChatToggle<CR>')
      -- CopilotChatFix
      vim.keymap.set('v', '<leader>ccf', '<CMD>CopilotChatFix<CR>')
      -- CopilotChatExplain
      vim.keymap.set('v', '<leader>cce', '<CMD>CopilotChatExplain<CR>')
      -- CopilotChatReview
      vim.keymap.set('v', '<leader>ccr', '<CMD>CopilotChatReview<CR>')
      -- impl more: https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#commands-coming-from-default-prompts
    end,
  },
}
