local awful = require("awful")
local beautiful = require("beautiful")
local keysClient = require("bindings.keys").client

awful.rules.rules = {
	{ rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = keysClient,
			-- buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
	},

	-- floating clients
	{ rule_any = {
		instance = {
			"DTA",  -- firefox addon DownThemAll
			"copyq",  -- includes session name in class
			"pinentry",
		},
		class = {
			"Arandr",
			"Blueman-manager",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm
			"Sxiv",
			"Tor Browser", -- needs a fixed window size to avoid fingerprinting by screen size
			"Wpa_gui",
			"veromix",
			"xtightvncviewer"},

		-- note that the name property shown in xprop might be set slightly after creation of the client
		-- and the name shown there might not match defined rules here
		name = {
			"Event Tester",  -- xev.
		},
		role = {
			"AlarmWindow",  -- Thunderbird's calendar
			"ConfigManager",  -- Thunderbird's about:config
			"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools
		}
	}, properties = { floating = true }}}
