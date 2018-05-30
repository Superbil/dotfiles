-- Bluetooth mode

function bluetoothSwith()
   local statusOutput = hs.execute("defaults read /Library/Preferences/com.apple.Bluetooth ControllerPowerState | awk '{ if($1 != 0) {print \"Bluetooth: ON\"} else { print \"Bluetooth: OFF\" }")
   local bluetoothStatus do
      if tonumber(statusOutput) == 1 then
         bluetoothStatus = true
      else
         bluetoothStatus = false
      end
   end
   local command_temp = "sudo defaults write /Library/Preferences/com.apple.Bluetooth ControllerPowerState -int %s && sudo killall -HUP blued"
   local output, status
   if bluetoothStatus then
      -- Disable
      output, status = hs.execute(string.format(command_temp, "0"))
   else
      -- Enable
      output, status = hs.execute(string.format(command_temp, "1"))
   end
   if status then
      local o do
         if bluetoothStatus then
            o = "Disable"
         else
            o = "Enable"
         end
      end
      hs.alert.show(String.format("Bluetooth switch success to %s", o))
   else
      hs.alert.show("Bluetooth switch failed")
      hs.printf("output %s status %s", output, status)
   end
end
