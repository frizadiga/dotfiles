local M = {}

-- fn to open a floating window
function M.open_floating_window(buf_body, width, height)
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

  local final_width
  local final_height

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

return M
