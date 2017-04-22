-------------------------------------------------------------------------------
-- real configuration
-------------------------------------------------------------------------------
-- variable config
hs.window.animationDuration = 0
hs.window.setShadows(false)
primaryScreen = hs.screen.primaryScreen()
local secoundScreen = primaryScreen:toEast()

require "preload"

-- grid config
hs.grid.setMargins({0, 0})
hs.grid.setGrid('11x2', primaryScreen)
hs.grid.setGrid('2x2', secoundScreen)
if primaryScreen:name() == "Color LCD" then
   hs.grid.setGrid('2x2', primaryScreen)
end

-- Hotkeys

-- Chat
hs.hotkey.bind(keys.ca, "h", function() pushGrid('0,0 4x4', primaryScreen) end)
hs.hotkey.bind(keys.ca, "u", function() pushGrid('0,0 2x1', primaryScreen) end)
hs.hotkey.bind(keys.ca, "j", function () pushGrid('0,0 2x4', primaryScreen) end)
hs.hotkey.bind(keys.ca, "m", function () pushGrid('0,1 2x1', primaryScreen) end)

-- Left
hs.hotkey.bind(keys.ca, "i", function() pushGrid('2,0 2x1', primaryScreen) end)
hs.hotkey.bind(keys.ca, "k", function () pushGrid('2,0 2x4', primaryScreen) end)
hs.hotkey.bind(keys.ca, ",", function () pushGrid('2,1 2x1', primaryScreen) end)

-- Center
hs.hotkey.bind(keys.ca, "o", function () pushGrid('4,0 7x2', primaryScreen) end)
hs.hotkey.bind(keys.ca, "l", function () pushGrid('2,0 9x2', primaryScreen) end)

-- Main
hs.hotkey.bind(keys.ca, ".", function () pushScreen(primaryScreen,0.1,0.1,0.8,0.8) end)

-- Full screen
hs.hotkey.bind(keys.ca, "n", function() pushScreen(primaryScreen,0,0,1,1) end)
hs.hotkey.bind(keys.ca, "p", function() pushScreen(secoundScreen,0,0,1,1) end)

-- Resize window by grid
hs.hotkey.bind(keys.cac, "right", function() hs.grid.resizeWindowWider() end)
hs.hotkey.bind(keys.cac, "left", function() hs.grid.resizeWindowThinner() end)
hs.hotkey.bind(keys.cac, "up", function() hs.grid.resizeWindowShorter() end)
hs.hotkey.bind(keys.cac, "down", function() hs.grid.resizeWindowTaller() end)

-- Nudge window by grid
hs.hotkey.bind(keys.ca, "right", function() hs.grid.pushWindowRight() end)
hs.hotkey.bind(keys.ca, "left", function() hs.grid.pushWindowLeft() end)
hs.hotkey.bind(keys.ca, "up", function() hs.grid.pushWindowUp() end)
hs.hotkey.bind(keys.ca, "down", function() hs.grid.pushWindowDown() end)

-- Everything is fine
hs.alert.show("Hammerspoon Config loaded")
