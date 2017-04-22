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

hs.hotkey.bind(keys.c, "escape", function() hs.grid.show() end)
hs.hotkey.bind(keys.cac, "b", function() hs.openConsole() end)

-- core user modules
require "imgur"
