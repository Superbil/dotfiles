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
