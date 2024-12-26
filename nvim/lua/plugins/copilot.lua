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
      local cc = require 'CopilotChat'

      local def_win_opt = {
        title = '',
        layout = 'float',
        relative = 'editor',
        border = 'single',
        width = 80,
        height = 15,
      }

      cc.setup({
        debug = false,
        error_header = 'Err',
        answer_header = '▶︎ A',
        question_header = '▶︎ Q',
        separator = '',
        window = def_win_opt,
        mappings = {
          submit_prompt = {
            normal = '<CR>',
            insert = '<C-;>',
          },
          accept_diff = {
            normal = '<Space><Space>',
          },
          reset = {
            normal = '<C-l>', insert = '<C-l>', },
          complete = {
            insert ='<S-Tab>', -- prevent conflict with copilot ghost suggestion
            detail = 'Use @<Tab> or /<Tab> for options.',
            -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/324#issuecomment-2118551487
          },
        },
        agent = 'copilot', -- see ':CopilotChatAgents' for available agents (can be specified manually in prompt via @).
        model = 'claude-3.5-sonnet', -- see ':CopilotChatModels' for available models (can be specified manually in prompt via $).
        context = nil, -- default context or array of contexts to use (can be specified manually in prompt via #).
        temperature = 0.1, -- LLM result temperature (0.0 - 1.0) closer to 0 is more deterministic, closer to 1 is more "creative".
        -- default config see: https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/canary/lua/CopilotChat/config.lua#L81
      })

      -- file-type handler for 'copilot-chat'
      vim.api.nvim_create_autocmd("BufEnter", {
        pattern = "copilot-chat",
        callback = function()
          vim.opt_local.number = false
          vim.opt_local.relativenumber = false
        end,
      })

      -- show chat window
      vim.keymap.set({ 'n', 'v' }, '<leader>ccc', cc.open)

      -- show chat window with fix instructions
      vim.keymap.set('v', '<leader>ccf', '<CMD>CopilotChatFix<CR>')

      -- show chat window with review instructions
      vim.keymap.set('v', '<leader>ccr', '<CMD>CopilotChatReview<CR>')

      -- show chat window with explain instructions
      vim.keymap.set('v', '<leader>cce', '<CMD>CopilotChatExplain<CR>')

      -- select model
      vim.keymap.set('n', '<leader>ccm', '<CMD>CopilotChatModels<CR>')

      -- show current model
      vim.keymap.set('n', '<leader>ccM', function() vim.notify(cc.config.model) end)

      local max_win_opt = vim.tbl_extend('force', def_win_opt, {
        width = 1.0,
        height = 1.0,
        border = 'none',
      })

      -- show max chat window
      vim.keymap.set({ 'n', 'v' }, '<leader>ccC', function() cc.open { window = max_win_opt } end)

      -- impl more: https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#commands-coming-from-default-prompts
    end,
  },
}
