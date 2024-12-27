-- clear all system notifications
local function clear_system_notifications()
  local script = [[
    tell application 'System Events'
      tell process 'Notification Center'
        set notificationWindows to every window
        repeat with notificationWindow in notificationWindows
          try
            click button 1 of notificationWindow
          end try
        end repeat
      end tell
    end tell
  ]]
  hs.osascript.applescript(script)
  print('All notifications cleared!')
end

-- clear all system notifications
hs.hotkey.bind({ 'cmd', 'alt', 'ctrl' }, 'C', function()
  -- clear hs notifications
  hs.notify.withdrawAll()
  -- clear system notifications
  clear_system_notifications()

  -- show confirmation
  hs.alert.show('Cleared all notifications')
end)

-- close all visible notifications in notification center.
hs.hotkey.bind({ "ctrl", "cmd" }, "delete", function()
  hs.task
    .new("/usr/bin/osascript", nil, {
      "-l",
      "JavaScript",
      os.getenv("HOME") .. "/Documents/main/dotfiles/hammerspoon/notifications.js",
    })
    :start()
end)
