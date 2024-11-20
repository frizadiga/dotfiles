-- @start create user commands
-- fn to print reverse lines
-- local function print_reverse_lines(output)
--   -- Split output into lines
--   local lines = vim.fn.split(output, '\n')
--
--   -- Print reverse of lines
--   for i = #lines, 1, -1 do
--     print(lines[i])
--   end
--
--   -- Example usage
--   -- local output = "line1\nline2\nline3"
--   -- print_reverse_lines(output)
-- end

-- Lazy alias
vim.api.nvim_create_user_command('L',
  function(opts)
    vim.cmd('Lazy ' .. opts.args)
  end,
  {
    nargs = '*',
    complete = 'custom,v:lua.require("lazy.view").complete'
  }
)

-- run todo.sh and print output
vim.api.nvim_create_user_command(
  'Todo',
  function()
    local tools_dir = vim.fn.expand('$TOOLS_DIR')
    local output = vim.fn.system({'bash', tools_dir .. '/todo.sh'})

    vim.notify('\n' .. output)
  end,
  {}
)

-- new daily open command
vim.api.nvim_create_user_command(
  'D',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({'bash', notes_dir .. '/app/schd-new-daily.sh'})

    -- get last line of output
    local lines = vim.fn.split(output, '\n')
    local today_filepath = vim.fn.trim(lines[#lines])

    -- if today file exists, open it
    if vim.fn.filereadable(today_filepath) == 1 then
      vim.cmd('e ' .. today_filepath)
    end

    vim.notify('\n' .. output)
  end,
  {}
)

-- check detail ticket
vim.api.nvim_create_user_command(
  'TicketDetail',
  function()
    local tools_dir = vim.fn.expand('$TOOLS_DIR')
    local output = vim.fn.system({'bash', tools_dir .. '/jira-curl/curl-issue-find-one.sh'})

    vim.notify('\n' .. output)
  end,
  {}
)
-- @end create user commands
