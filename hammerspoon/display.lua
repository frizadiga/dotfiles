-- detect display change
-- hs.screen.watcher.new(function()
-- hs.alert.show("Display changed", 5)
-- end):start()
-- hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "D", function()
--   hs.alert.show("Display count: " .. #hs.screen.allScreens())
-- end)

-- initialize a screen watcher
local screenWatcher = nil

-- custom handler screen changes
local function handleScreenChange()
  local screens = hs.screen.allScreens()
  local numScreens = #screens

  -- log screen change details
  print(string.format("Screen change detected! Number of displays: %d", numScreens))

  -- loop through all screens and print their details
  for i, screen in ipairs(screens) do
    local name = screen:name()
    local id = screen:id()
    local resolution = table.concat({screen:currentMode().w, screen:currentMode().h}, "x")

    print(string.format("Display %d:", i))
    print(string.format("  Name: %s", name))
    print(string.format("  ID: %s", id))
    print(string.format("  Resolution: %s", resolution))
  end
end

-- start watching for screen changes
local function startScreenWatcher()
  -- stop existing watcher if it's running
  if screenWatcher then
    screenWatcher:stop()
  end

  -- create and start new screen watcher
  screenWatcher = hs.screen.watcher.new(handleScreenChange)
  screenWatcher:start()

  -- log initial screen setup
  print("Screen watcher started")
  handleScreenChange()
end

-- stop watching for screen changes
local function stopScreenWatcher()
  if screenWatcher then
    screenWatcher:stop()
    screenWatcher = nil
    print("Screen watcher stopped")
  end
end

-- start the watcher immediately
startScreenWatcher()

-- optional: bind to hotkeys
hs.hotkey.bind({"cmd", "alt"}, "s", startScreenWatcher)
hs.hotkey.bind({"cmd", "alt"}, "x", stopScreenWatcher)
