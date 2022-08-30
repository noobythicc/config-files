local wibox = require("wibox")
local awful = require("awful")
 
network_widget = wibox.widget.textbox()
 
function update_network(widget)
   local getnetwork = io.popen("nmcli -o | awk '$1 == \"wlp3s0:\" { print $2\" \"$3\" \"$4 }'")
   local network = getnetwork:read("*all")
   getnetwork:close()
 
   widget:set_markup(network)
end
 
update_network(network_widget)
 
mytimer = timer({ timeout = 4 })
mytimer:connect_signal("timeout", function () update_network(network_widget) end)
mytimer:start()
