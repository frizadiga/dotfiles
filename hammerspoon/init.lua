hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "H", function()
  hs.alert.show("Hello Bastard!")
end)

hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", function()
  hs.reload()
end)
hs.alert.show("Config loaded")
