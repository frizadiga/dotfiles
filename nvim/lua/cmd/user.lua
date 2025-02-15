-- @start create user commands

local float_win = require 'shared.float_window'
local open_floating_window = float_win.open_floating_window
local clipboard = require 'shared.clipboard'
local copy_to_clip = clipboard.copy_to_clip

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

    open_floating_window('# RTP List:\n \n' .. table.concat(output, '\n'), 80, 30)
  end,
  {}
)

-- run todo.sh and print output
vim.api.nvim_create_user_command(
  'Todo',
  function()
    local tools_dir = vim.fn.expand('$TOOLS_DIR')
    local output = vim.fn.system({ 'bash', tools_dir .. '/todo.sh' })

    open_floating_window('# Todo:\n' .. output, 80, 15)
  end,
  {}
)

-- copy current file path to clipboard
vim.api.nvim_create_user_command(
  'CopyPath',
  function()
    local file_path = vim.fn.expand('%:p')
    copy_to_clip(file_path)
  end,
  {}
)

-- copy current file name to clipboard
vim.api.nvim_create_user_command(
  'CopyName',
  function()
    local file_name = vim.fn.expand('%:t')
    copy_to_clip(file_name)
  end,
  {}
)

-- copy current directory path to clipboard
vim.api.nvim_create_user_command(
  'CopyDir',
  function()
    local dir_path = vim.fn.expand('%:p:h')
    copy_to_clip(dir_path)
  end,
  {}
)

-- copy current filepath in remote url to clipboard
vim.api.nvim_create_user_command(
  'CopyRemoteUrl',
  function()
    local file_path = vim.fn.expand('%:p')

    -- get the git root of the main repository
    local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')

    -- check if the file is in a submodule
    local is_submodule = false
    local submodule_root = ''
    local submodule_path = ''

    -- get list of submodules and their paths
    local submodules = vim.fn.system('git config --file .gitmodules --get-regexp path'):gsub('\n$', '')
    if submodules ~= '' then
      for line in submodules:gmatch('[^\n]+') do
        local _, path = line:match('submodule%.(.-)%.path%s+(.*)')
        if path then
          local full_path = git_root .. '/' .. path
          if file_path:sub(1, #full_path) == full_path then
            is_submodule = true
            submodule_path = path
            -- get the submodule root
            submodule_root = vim.fn.system('cd ' .. full_path .. ' && git rev-parse --show-toplevel'):gsub('\n', '')
            break
          end
        end
      end
    end

    local relative_file_path, remote_url, current_branch

    if is_submodule then
      -- handle submodule case
      relative_file_path = file_path:sub(#submodule_root + 2)
      remote_url = vim.fn.system('cd ' .. git_root .. '/' .. submodule_path .. ' && git remote get-url origin'):gsub('\n', '')
      current_branch = vim.fn.system('cd ' .. git_root .. '/' .. submodule_path .. ' && git branch --show-current'):gsub('\n', '')
    else
      -- handle main repository case
      relative_file_path = file_path:sub(#git_root + 2)
      remote_url = vim.fn.system('git remote get-url origin'):gsub('\n', '')
      current_branch = vim.fn.system('git branch --show-current'):gsub('\n', '')
    end

    if remote_url:match('^git@') then
      -- handle SSH URL (e.g., git@github.com:user/repo.git)
      remote_url = remote_url:gsub(':', '/')
      remote_url = remote_url:gsub('%.git', '')
      remote_url = remote_url:gsub('git@', 'https://')
    end

    if remote_url:match('^https://') then
      -- handle HTTPS URL (e.g., https://github.com/user/repo.git)
      remote_url = remote_url:gsub('%.git', '')
      -- remove any token or authentication part (e.g., https://token@github.com/user/repo.git)
      remote_url = remote_url:gsub('https://[^@]+@', 'https://')
    end

    local final_url = remote_url .. '/blob/' .. current_branch .. '/' .. relative_file_path
    copy_to_clip(final_url)
  end,
  {}
)

-- run git log
vim.api.nvim_create_user_command(
  'GL',
  function()
    -- local output = vim.fn.system({'git', 'log', '--oneline', '--graph', '--decorate', '--all'})
    local output = vim.fn.system({ 'git', 'log', '--pretty=format:- %h %ad %ae\n  msg: %s', '--date=format:%Y-%m-%d %H:%M' })

    open_floating_window('# Git Log:\n' .. output, 60, 20)
  end,
  {}
)

-- new daily open command
vim.api.nvim_create_user_command(
  'D',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({ 'bash', notes_dir .. '/app/schd-new-daily.sh' })

    -- get last line of output
    local lines = vim.fn.split(output, '\n')
    local today_filepath = vim.fn.trim(lines[#lines])

    -- if today file exists, open it
    if vim.fn.filereadable(today_filepath) == 1 then
      vim.cmd('e ' .. today_filepath)
    end

    vim.notify('\n' .. output, vim.log.levels.INFO)
  end,
  {}
)

-- daily latest
vim.api.nvim_create_user_command(
  'DL',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({ 'bash', notes_dir .. '/app/finder/finder-latest.sh' })

    -- get last line of output
    local lines = vim.fn.split(output, '\n')
    local latest_filepath = vim.fn.trim(lines[#lines])

    -- if latest file exists, open it
    if vim.fn.filereadable(latest_filepath) == 1 then
      vim.cmd('e ' .. latest_filepath)
    end

    vim.notify('\nfinder latest:\n' .. output, vim.log.levels.INFO)
  end,
  {}
)

-- daily previous
vim.api.nvim_create_user_command(
  'DP',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({ 'bash', notes_dir .. '/app/finder/finder-prev.sh' })

    -- get last line of output
    local lines = vim.fn.split(output, '\n')
    local prev_filepath = vim.fn.trim(lines[#lines])

    -- if previous file exists, open it
    if vim.fn.filereadable(prev_filepath) == 1 then
      vim.cmd('e ' .. prev_filepath)
    end

    vim.notify('\nfinder previous:\n' .. output, vim.log.levels.INFO)
  end,
  {}
)

-- info detail ticket
vim.api.nvim_create_user_command(
  'TicketDetail',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({ 'bun', notes_dir .. '/app/tasks/what_task.ts' })

    open_floating_window('# Ticket Detail:\n' .. output, 80, 10)
  end,
  {}
)

-- open ticket markdown
vim.api.nvim_create_user_command(
  'TicketMd',
  function()
    local notes_dir = vim.fn.expand('$NOTES_DIR')
    local output = vim.fn.system({ 'bash', notes_dir .. '/projects/products/open-md-product.sh', '--path' })

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
    local output = vim.fn.system({ 'bash', notes_dir .. '/app/browser-tabs/mod-tabs-by-ticket-id.sh' })

    vim.notify('\n' .. output)
  end,
  {}
)

-- @end create user commands
