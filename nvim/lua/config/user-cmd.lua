-- @start create user commands

-- fn to print reverse lines
-- local function print_reverse_lines(output)
--   -- split output into lines
--   local lines = vim.fn.split(output, '\n')
--
--   -- print reverse of lines
--   for i = #lines, 1, -1 do
--     print(lines[i])
--   end
-- end

-- fn to open a floating window
local function open_floating_window(content_buff, width, height)
  local width = width or 0.6  -- default width value
  local height = height or 0.6  -- default height value
  
  -- split the command output into lines
  local buffer_lines = {}
  for line in content_buff:gmatch("[^\r\n]+") do
    table.insert(buffer_lines, line)
  end

  -- create a new buffer and window
  local buf = vim.api.nvim_create_buf(false, true) -- nofile, scratch buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, buffer_lines)
  
  -- define floating window dimensions
  local _width = math.floor(vim.o.columns * width)
  local _height = math.floor(vim.o.lines * height)
  local row = math.floor((vim.o.lines - _height) / 2)
  local col = math.floor((vim.o.columns - _width) / 2)

  -- open the floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = _width,
    height = _height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })
end

-- lazy.nvim dashboard alias
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

    open_floating_window(output)
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

    open_floating_window(output)
  end,
  {}
)

-- @end create user commands
