local M = {}

-- fn to print reverse lines
function M.print_reverse_lines(output)
  -- split output into lines
  local lines = vim.fn.split(output, '\n')

  -- print reverse of lines
  for i = #lines, 1, -1 do
    print(lines[i])
  end
end

return M
