local wibox = require("wibox")
local awful = require("awful")
 
brightness_widget = wibox.widget.textbox()
 
function update_brightness(widget)
   local getbrightness = io.popen("brightnessctl g")
   local getmaxbrightness = io.popen("brightnessctl m")
   local brightness = getbrightness:read("*all")
   local maxbrightness = getmaxbrightness:read("*all")
   getbrightness:close()
   getmaxbrightness:close()

   widget:set_markup("Bri: " .. math.floor(brightness / maxbrightness * 100) .. "%")
end
 
update_brightness(brightness_widget)
 
mytimer = timer({ timeout = 0.2 })
mytimer:connect_signal("timeout", function () update_brightness(brightness_widget) end)
mytimer:start()
