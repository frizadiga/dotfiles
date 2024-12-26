require 'display'
require 'notification'

-- open hammerspoon console
hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'C', function()
  hs.openConsole()
end)

-- @TODO: auto reload config
hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'R', function()
  hs.reload()
end)
hs.alert.show('Config loaded')

