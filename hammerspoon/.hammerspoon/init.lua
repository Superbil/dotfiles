-------------------------------------------------------------------------------
-- real configuration
-------------------------------------------------------------------------------
-- variable config
hs.window.animationDuration = 0
hs.window.setShadows(false)
local primaryScreen = hs.screen.primaryScreen()
local secoundScreen = primaryScreen:toEast()

-- grid config
hs.grid.setGrid('11x2', primaryScreen)
hs.grid.setMargins(hs.geometry.size(0,0))
hs.grid.setGrid('2x2', secoundScreen)

-- keyboard modifiers for bindings
local keys = {
   c   = {'ctrl'               },
   ca  = {'ctrl', 'alt'        },
   cac = {'cmd',  'alt', 'ctrl'}
}

-- Hotkeys
hs.hotkey.bind(keys.c, "escape", function() hs.grid.show() end)
hs.hotkey.bind(keys.cac, "b", function() hs.openConsole() end)

hs.hotkey.bind(keys.ca, "h", function() pushGrid('0,0 2x1', primaryScreen) end)         -- chat-left

hs.hotkey.bind(keys.ca, "u", function() pushGrid('0,0 2x1', primaryScreen) end)         -- chat-t
hs.hotkey.bind(keys.ca, "j", function() pushGrid('0,0 2x4', primaryScreen) end)        -- chat
hs.hotkey.bind(keys.ca, "m", function() pushGrid('0,1 2x1', primaryScreen) end)        -- chat-b

hs.hotkey.bind(keys.ca, "i", function() pushGrid('2,0 2x1', primaryScreen) end)         -- left2-t
hs.hotkey.bind(keys.ca, "k", function() pushGrid('2,0 2x4', primaryScreen) end)        -- left2
hs.hotkey.bind(keys.ca, ",", function() pushGrid('2,1 2x1', primaryScreen) end)        -- left2-b

hs.hotkey.bind(keys.ca, "o", function() pushGrid('4,0 7x2', primaryScreen) end)        -- main
hs.hotkey.bind(keys.ca, "l", function() pushGrid('2,0 9x2', primaryScreen) end)        -- bighMain

hs.hotkey.bind(keys.ca, ".", function() pushScreen(primaryScreen,0.1,0.1,0.8,0.8) end) -- center

hs.hotkey.bind(keys.ca, "n", function() pushScreen(primaryScreen,0,0,1,1) end)          -- full screen on screen 1
hs.hotkey.bind(keys.ca, "p", function() pushScreen(secoundScreen,0,0,1,1) end)          -- full screen on screen 2

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

-- iTunes
hs.hotkey.bind(keys.c, "f3", function() hs.itunes.next() end)
hs.hotkey.bind(keys.c, "f2", function() hs.itunes.playpause() end)
hs.hotkey.bind(keys.c, "f1", function() hs.itunes.previous() end)

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

-- Airplane mode
hs.hotkey.bind(keys.cac, "a", function() airplanMode() end)

doAirplan = false
function airplanMode()
   local wifiFace = ''
   if doAirplan then
      wifiFace = 'Automatic'
   else
      wifiFace = 'AirplaneMode'
   end

   output, status, rtype, rc = hs.execute('scselect ' .. wifiFace)
   if status then
      hs.alert.show('Wifi -> ' .. wifiFace)
      doAirplan = true
   else
      hs.alert.show('Change Wifi failed')
   end
end

-- Reload config
hs.hotkey.bind(keys.cac, "R", function()
  hs.reload()
end)

function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
local hammerspoon_watcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

-------------------------------------------------------------------------------
-- from https://github.com/exark/dotfiles/blob/master/.hammerspoon/init.lua
-- Resize window for chunk of screen.
-- For x and y: use 0 to expand fully in that dimension, 0.5 to expand halfway
-- For w and h: use 1 for full, 0.5 for half
-------------------------------------------------------------------------------
function push(x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w*x)
  f.y = max.y + (max.h*y)
  f.w = max.w*w
  f.h = max.h*h
  win:setFrame(f)
end

function pushWindow(win, x, y, w, h)
  local f = win:frame()
  local screen = win:screen()
  local max = screen:frame()

  f.x = max.x + (max.w*x)
  f.y = max.y + (max.h*y)
  f.w = max.w*w
  f.h = max.h*h
  win:setFrame(f)
end

function pushScreen(screen, x, y, w, h)
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local max = screen:frame()

  f.x = max.x + (max.w*x)
  f.y = max.y + (max.h*y)
  f.w = max.w*w
  f.h = max.h*h
  win:setFrame(f)
end

function pushGrid(cell, screen)
   local win = hs.window.focusedWindow()
   hs.grid.set(win, cell, screen)
end

-- Everything is fine
hs.alert.show("Hammerspoon Config loaded")
