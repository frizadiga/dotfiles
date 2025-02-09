function Status:name()
  local h = self._current.hovered

  -- @NOTES: default format
  -- if not h then
  --   return ''
  -- end
  --
  -- return ' ' .. h.name:gsub('\r', '?', 1)

  -- @NOTES: add symlink full path
  local linked = ''
  if h.link_to ~= nil then
    linked = ' -> ' .. tostring(h.link_to)
  end

  return ui.Line(' ' .. h.name .. linked)
end

require 'full-border':setup {
  type = ui.Border.ROUNDED, -- PLAIN | ROUNDED
}
