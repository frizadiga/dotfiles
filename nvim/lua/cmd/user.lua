-- @start create user commands

-- fn to print reverse lines
-- local function print_reverse_lines(output)
--   -- split output into lines
--   local lines = vim.fn.split(output, '\n')
--
--   -- print reverse of lines
--   for i = #lines, 1, -1 do print(lines[i])
--   end
-- end

-- fn to open a floating window
local function open_floating_window(buf_body, width, height)
  local _width = width or 0.6
  local _height = height or 0.6

  -- split the command output into lines
  local buf_lines = {}
  for line in buf_body:gmatch("[^\r\n]+") do
    table.insert(buf_lines, line)
  end

  -- create a new buffer and window
  local buf = vim.api.nvim_create_buf(false, true) -- nofile, scratch buffer
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, buf_lines)

  local final_width = 0.2
  local final_height = 0.2

  if _width > 1 then
    -- use normal unit
    final_width = _width
  else
    -- use percentage unit of current window
    final_width = math.floor(vim.o.columns * _width)
  end

  if _height > 1 then
    -- use normal unit
    final_height = _height
  else
    -- use percentage unit of current window
    final_height = math.floor(vim.o.lines * _height)
  end

  local row = math.floor((vim.o.lines - final_height) / 2)
  local col = math.floor((vim.o.columns - final_width) / 2)

  -- open the floating window
  vim.api.nvim_open_win(buf, true, {
    style = "minimal",
    border = "rounded",
    relative = "editor",
    row = row,
    col = col,
    width = final_width,
    height = final_height,
  })
end

-- lazy.nvim dashboard alias
vim.api.nvim_create_user_command(
  'L',
  function(opts)
    vim.cmd('Lazy ' .. opts.args)
  end,
  {
    nargs = '*',
    complete = 'custom,v:lua.require("lazy.view").complete'
  }
)

-- run nvim_list_runtime_paths
vim.api.nvim_create_user_command(
  'RTPList',
  function()
    -- get runtime paths as table
    local output = vim.api.nvim_list_runtime_paths()

    open_floating_window('# RTP List:\n \n' .. table.concat(output, '\n'), 70, 30)
  end,
  {}
)

-- run todo.sh and print output
vim.api.nvim_create_user_command(
  'Todo',
  function()
    local tools_dir = vim.fn.expand('$TOOLS_DIR')
    local output = vim.fn.system({'bash', tools_dir .. '/todo.sh'})

    open_floating_window('# Todo:\n' .. output, 60, 10)
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

    vim.notify('\n' .. output, vim.log.levels.INFO, { timeout = 10000 })
  end,
  {}
)

-- daily latest
vim.api.nvim_create_user_command(
  'DL',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({'bash', notes_dir .. '/app/finder/finder-latest.sh'})

    -- get last line of output
    local lines = vim.fn.split(output, '\n')
    local today_filepath = vim.fn.trim(lines[#lines])

    -- if today file exists, open it
    if vim.fn.filereadable(today_filepath) == 1 then
      vim.cmd('e ' .. today_filepath)
    end

    vim.notify('\nfinder latest:\n' .. output, vim.log.levels.INFO, { timeout = 10000 })
  end,
  {}
)

-- daily previous
vim.api.nvim_create_user_command(
  'DP',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({'bash', notes_dir .. '/app/finder/finder-prev.sh'})

    -- get last line of output
    local lines = vim.fn.split(output, '\n')
    local today_filepath = vim.fn.trim(lines[#lines])

    -- if today file exists, open it
    if vim.fn.filereadable(today_filepath) == 1 then
      vim.cmd('e ' .. today_filepath)
    end

    vim.notify('\nfinder previous:\n' .. output, vim.log.levels.INFO, { timeout = 10000 })
  end,
  {}
)

-- info detail ticket
vim.api.nvim_create_user_command(
  'TicketDetail',
  function()
    local tools_dir = vim.fn.expand('$TOOLS_DIR')
    local output = vim.fn.system({'bash', tools_dir .. '/jira-curl/curl-issue-find-one.sh'})

    open_floating_window('# Ticket Detail:\n' .. output, 60, 7)
  end,
  {}
)

-- open ticket markdown
vim.api.nvim_create_user_command(
  'TicketMd',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({'bash', notes_dir .. '/projects/products/open-md-product.sh', '--path'})

    -- get last line of output
    local lines = vim.fn.split(output, '\n')
    local md_filepath = vim.fn.trim(lines[#lines])

    -- if md file exists, open it
    if vim.fn.filereadable(md_filepath) == 1 then
      vim.cmd('e ' .. md_filepath)
    end

    vim.notify('\n' .. output)
  end,
  {}
)

-- open tabs ticket related
vim.api.nvim_create_user_command(
  'TicketTabs',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({'bash', notes_dir .. '/app/browser-tabs/mod-tabs-by-ticket-id.sh'})

    vim.notify('\n' .. output)
  end,
  {}
)

-- @end create user commands
