local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")

client.connect_signal("manage", function(c)
	c.border_color = c == client.focus and beautiful.border_focus or beautiful.border_normal

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
		awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c)
	c.border_color = beautiful.border_focus
end)

client.connect_signal("unfocus", function(c)
	c.border_color = beautiful.border_normal
end)
