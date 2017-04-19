-- Reload config
hs.hotkey.bind({"cmd", "alt", "ctrl"}, "R", function()
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

function executeShellScript (filePath)
   aslog = hs.logger.new('executeShellScript','debug')
   -- Must change to string
   local command = string.format('do shell script %q', filePath)
   aslog.df(command)
   ok,result,message = hs.osascript.applescript(command)
   aslog.v(ok)
   if result then
      aslog.d('success ' .. result)
   else
      aslog.d('failed')
      for key, val in pairs(message) do
         print(key, val)
      end
   end
end

-- Everything is fine
hs.alert.show("Hammerspoon Config loaded")
