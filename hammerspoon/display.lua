-- detect display change
-- hs.screen.watcher.new(function()
-- hs.alert.show('Display changed', 5)
-- end):start()
-- hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'D', function()
--   hs.alert.show('Display count: ' .. #hs.screen.allScreens())
-- end)

-- initialize a screen watcher
local screenWatcher = nil

-- custom handler screen changes
local function handle_screen_change()
  local screens = hs.screen.allScreens()
  local numScreens = #screens

  -- log screen change details
  print(string.format('Screen change detected! Number of displays: %d', numScreens))

  -- loop through all screens and print their details
  for i, screen in ipairs(screens) do
    local name = screen:name()
    local id = screen:id()
    local resolution = table.concat({ screen:currentMode().w, screen:currentMode().h }, 'x')

    print(string.format('ID: %s', id))
    print(string.format('Display %d:', i))
    print(string.format('Name: %s', name))
    print(string.format('Resolution: %s', resolution))
  end

  -- call external handler script
  -- fn signature: hs.execute(command[, with_user_env]) -> output, status, type, rc
  -- @TODO: figure out alternative implementation to make user env load faster
  hs.execute('bash ' .. os.getenv('HOME') .. '/Documents/tools/audio-switch-by-display.sh', true)
  hs.execute('bash ' .. os.getenv('HOME') .. '/Documents/tools/layout-corrector/layout-corrector.sh', true)
end

-- start watching for screen changes
local function start_screen_watcher()
  -- stop existing watcher if it's running
  if screenWatcher then
    screenWatcher:stop()
  end

  -- create and start new screen watcher
  screenWatcher = hs.screen.watcher.new(handle_screen_change)
  screenWatcher:start()

  -- log initial screen setup
  print('Screen watcher started')
  handle_screen_change()
end

-- stop watching for screen changes
local function stop_screen_watcher()
  if screenWatcher then
    screenWatcher:stop()
    screenWatcher = nil
    print('Screen watcher stopped')
  end
end

-- start the watcher immediately
start_screen_watcher()

-- optional: bind to hotkeys
hs.hotkey.bind({ 'cmd', 'alt' }, 's', start_screen_watcher)
hs.hotkey.bind({ 'cmd', 'alt' }, 'x', stop_screen_watcher)
