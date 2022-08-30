local wibox = require("wibox")
local awful = require("awful")
 
memory_widget = wibox.widget.textbox()
 
function update_memory(widget)
   local getmemory = io.popen("free -h | awk '$1 == \"Mem:\" {print $2}' | tr -d '\n'")
   local memory = getmemory:read("*all")
   getmemory:close()

   local getavailable = io.popen("free -h | awk '$1 == \"Mem:\" {print $3}' | tr -d '\n'")
   local available = getavailable:read("*all")
   getavailable:close()
 
   widget:set_markup("Mem: " .. available .. " / " .. memory)
end
 
update_memory(memory_widget)
 
mytimer = timer({ timeout = 2 })
mytimer:connect_signal("timeout", function () update_memory(memory_widget) end)
mytimer:start()
