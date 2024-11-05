return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "canary",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
      -- { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    -- see commands section for default commands if you want to lazy load on them
    config = function()
      require("CopilotChat").setup({
        debug = false, -- enable debugging
        -- see configuration section for rest
        -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/canary/lua/CopilotChat/config.lua#L81
        mappings = {
          complete = {
            insert ='<S-Tab>',
            detail = 'Use @<Tab> or /<Tab> for options.',
            -- https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/324#issuecomment-2118551487
          }
        },
        window = {
          title = '',
          layout = "float", -- horizontal, vertical, float, replace,
          relative = 'win', -- 'editor', 'win', 'cursor', 'mouse'
          border = 'single', -- 'none', 'single', 'double', 'rounded', 'solid', 'shadow',
          width = 0.6, -- fractional width of parent, or absolute width in columns when > 1
          height = 0.6, -- fractional height of parent, or absolute height in rows when > 1
        }
      })
      -- CopilotChatToggle
      vim.api.nvim_set_keymap("n", "<leader>ccc", "<cmd>CopilotChatToggle<CR>", { noremap = true, silent = true })
      -- CopilotChatFix
      vim.api.nvim_set_keymap("v", "<leader>ccf", "<cmd>CopilotChatFix<CR>", { noremap = true, silent = true })
      -- CopilotChatExplain
      vim.api.nvim_set_keymap("v", "<leader>cce", "<cmd>CopilotChatExplain<CR>", { noremap = true, silent = true })
      -- CopilotChatReview
      vim.api.nvim_set_keymap("v", "<leader>ccr", "<cmd>CopilotChatReview<CR>", { noremap = true, silent = true })
      -- impl more: https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#commands-coming-from-default-prompts
    end,
  },
}
