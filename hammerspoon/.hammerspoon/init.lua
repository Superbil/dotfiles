-- Variable config
hs.window.animationDuration = 0
hs.window.setShadows(false)
primaryScreen = hs.screen.primaryScreen()

-- auto reload config
configFileWatcher = hs.pathwatcher.new(hs.configdir, hs.reload):start()

-- keyboard modifiers for bindings
keys = {
   c   = {'ctrl'               },
   ca  = {'ctrl', 'alt'        },
   cac = {'cmd',  'alt', 'ctrl'},
   cas = {'ctrl', 'alt', 'shift'}
}

-- useful keybindings
hs.hotkey.bind(keys.cac, "R", function()
  hs.reload()
end)

function toggleConsole()
   local win = hs.window.focusedWindow()
   -- When win is nil, just call openConsole
   if not win then hs.openConsole() end

   if win:application():title() == "Hammerspoon" and win:isVisible() then
      win:close()
   else
      hs.openConsole()
   end
end
hs.hotkey.bind(keys.cac, "b", function() toggleConsole() end)
hs.hotkey.bind(keys.c, "escape", function() hs.grid.show() end)

-- iTunes
hs.hotkey.bind(keys.c, "f3", function() hs.itunes.next() end)
hs.hotkey.bind(keys.c, "f2", function() hs.itunes.playpause() end)
hs.hotkey.bind(keys.c, "f1", function() hs.itunes.previous() end)

-- core user modules
require "imgur"
require "airport"
require "resize"

-- Grid config
hs.grid.setMargins({0, 0})
hs.grid.setGrid('11x2', primaryScreen)
hs.grid.setGrid('2x2', secoundScreen)
if primaryScreen:name() == "Color LCD" then
   hs.grid.setGrid('2x2', primaryScreen)
end

-- Hotkeys

hs.hotkey.bind(keys.cac, "a", function() airplanMode() end)

-- Chat
hs.hotkey.bind(keys.ca, "h", function() pushGrid('0,0 4x4', primaryScreen) end)
hs.hotkey.bind(keys.ca, "j", function() pushGrid('0,0 2x4', primaryScreen) end)
hs.hotkey.bind(keys.ca, "m", function() pushGrid('0,1 2x1', primaryScreen) end)

-- Left
hs.hotkey.bind(keys.ca, "k", function() pushGrid('2,0 2x4', primaryScreen) end)
hs.hotkey.bind(keys.ca, ",", function() pushGrid('2,1 2x1', primaryScreen) end)

-- Center
hs.hotkey.bind(keys.ca, "o", function() pushGrid('4,0 7x2', primaryScreen) end)
hs.hotkey.bind(keys.ca, "l", function() pushGrid('2,0 9x2', primaryScreen) end)

-- Main
hs.hotkey.bind(keys.ca, ".", function() pushScreen(primaryScreen,0.1,0.1,0.8,0.8) end)

-- Full screen
hs.hotkey.bind(keys.ca, "n", function() pushScreen(primaryScreen,0,0,1,1) end)
hs.hotkey.bind(keys.ca, "p", function() pushScreen(primaryScreen:toEast(),0,0,1,1) end)

hs.hotkey.bind(keys.ca, "u", function() pushGrid('0,0 1x2', primaryScreen:toEast()) end)
hs.hotkey.bind(keys.ca, "i", function() pushGrid('1,0 1x2', primaryScreen:toEast()) end)

function getURLFromChrome()
   return hs.osascript.applescript(
      'set frontmostApplication to path to frontmost application\n \
tell application \"Google Chrome\"\n \
        set theUrl to get URL of active tab of first window\n \
        set theResult to (get theUrl) \n \
end tell\n \
activate application (frontmostApplication as text)\n \
set links to {}\n \
copy theResult to the end of links\n \
return links as string\n')
end

function sendToMpv()
   local win = hs.window.focusedWindow()
   if win:application():title() == "Google Chrome" then
      local success, url, descriptor = getURLFromChrome()
      if success and string.match(url, 'youtube.com') then
         print('mpv playing ' .. url)
         hs.notify.show("mpv", "", "Try to playing Youtube " .. url)
         s = os.execute(string.format('/usr/local/bin/mpv --fullscreen --screen 1 %s > /dev/null &', url))
         if s then
            return true
         else
            hs.notify.show("mpv", "", "Can't play url")
         end
      end
   end
   return false
end

hs.hotkey.bind(keys.cas, "p",
               function()
                  if not sendToMpv() then
                     pushScreen(primaryScreen:toEast(),0,0,1,1)
                  end
end)

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

hs.hotkey.bind(keys.cac, "y", function() imgurFromPasteboard() end)

-- Spoons


-- Everything is fine
hs.alert.show("Hammerspoon Config loaded")
