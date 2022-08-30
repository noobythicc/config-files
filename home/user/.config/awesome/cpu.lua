local wibox = require("wibox")
local awful = require("awful")
 
cpu_widget = wibox.widget.textbox()
 
function update_cpu(widget)
   local getcpu = io.popen("vmstat 1 2 | tail -1 | awk '{print $15'}")
   local cpu = 100 - tonumber(getcpu:read("*all"))
   getcpu:close()
 
   widget:set_markup("CPU: " .. cpu .. "%")
end
 
update_cpu(cpu_widget)
 
mytimer = timer({ timeout = 2 })
mytimer:connect_signal("timeout", function () update_cpu(cpu_widget) end)
mytimer:start()
