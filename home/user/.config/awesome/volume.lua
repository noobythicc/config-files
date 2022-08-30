local wibox = require("wibox")
local awful = require("awful")
 
volume_widget = wibox.widget.textbox()
 
function update_volume(widget)
   local getvolume = io.popen("pamixer --get-volume-human")
   local volume = getvolume:read("*all")
   getvolume:close()
 
   widget:set_markup("Vol: " .. volume)
end
 
update_volume(volume_widget)
 
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_volume(volume_widget) end)
mytimer:start()
