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
    opts = {
      debug = false, -- enable debugging
      -- see configuration section for rest
			-- https://github.com/CopilotC-Nvim/CopilotChat.nvim/blob/canary/lua/CopilotChat/config.lua
			window = {
				title = '',
				layout = "float", -- horizontal, vertical, float, replace,
				border = 'rounded', -- 'none', single', 'double', 'rounded', 'solid', 'shadow',
			}
    },
    -- see commands section for default commands if you want to lazy load on them
  },
}
