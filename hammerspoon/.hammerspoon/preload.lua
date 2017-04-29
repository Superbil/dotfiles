-- auto reload config
configFileWatcher = hs.pathwatcher.new(hs.configdir, hs.reload):start()

-- keyboard modifiers for bindings
keys = {
   c   = {'ctrl'               },
   ca  = {'ctrl', 'alt'        },
   cac = {'cmd',  'alt', 'ctrl'}
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
