local M = {}

function M.copy_to_clip(text)
  vim.fn.setreg('+', text)
  vim.notify('copied: ' .. text)
end

return M;
