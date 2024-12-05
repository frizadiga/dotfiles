return {
  {
    'github/copilot.vim',
    event = 'InsertEnter',
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    event = 'VeryLazy',
    branch = 'main',
    build = 'make tiktoken', -- only on MacOS or Linux
    config = function()
      require('CopilotChat').setup({
        debug = false, -- plugin level debug
        error_header = 'Err', -- header to use for errors
        answer_header = '▶︎ A', -- header to use for AI answers
        question_header = '▶︎ Q', -- header to use for user questions
        separator = '', -- disable separator to use in chat
        mappings = {
          submit_prompt = {
            normal = '<CR>',
            insert = '<C-;>',
          },
          accept_diff = {
            normal = '<Space><Space>',
          },
          reset = {
            normal = '<C-l>',
            insert = '<C-l>',
          },
          complete = {
            insert ='<S-Tab>', -- prevent conflict with copilot ghost suggestion
            detail = 'Use @<Tab> or /<Tab> for options.',
            -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/324#issuecomment-2118551487
          },
        },
        window = {
          title = '',
          layout = 'float', -- horizontal, vertical, float, replace,
          relative = 'win', -- 'editor', 'win', 'cursor', 'mouse'
          border = 'single', -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow',
          width = 80, -- fractional width of parent, or absolute width in columns when > 1
          height = 0.65, -- fractional height of parent, or absolute height in rows when > 1
        }
        -- more config see: https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/canary/lua/CopilotChat/config.lua#L81
      })

      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })

      -- CopilotChatFix
      vim.keymap.set('v', '<leader>ccf', '<CMD>CopilotChatFix<CR>')

      -- CopilotChatReview
      vim.keymap.set('v', '<leader>ccr', '<CMD>CopilotChatReview<CR>')

      -- CopilotChatExplain
      vim.keymap.set('v', '<leader>cce', '<CMD>CopilotChatExplain<CR>')

      -- CopilotChatModels
      vim.keymap.set('n', '<leader>ccm', '<CMD>CopilotChatModels<CR>')

      -- CopilotChatToggle
      vim.keymap.set({ 'n', 'v' }, '<leader>ccc', '<CMD>CopilotChatToggle<CR>')

      -- impl more: https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#commands-coming-from-default-prompts
    end,
  },
}
