local awful = require("awful")
local beautiful = require("beautiful")
local keysClient = require("bindings.keys").client

awful.rules.rules = {

	{
		rule = { class = "Dragon-drop" },
		properties = {
			floating = true,
			ontop = true,
			skip_taskbar = true,
			titlebars_enabled = false
		},
		callback = function(c)
			awful.placement.centered(c, { honor_workarea = true, honor_padding = true })
		end
	},

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

	-- how to use rules, use xprop to get app info
	-- {
	-- 	rule = {
	-- 		class = "firefox",
	-- 		instance = "navigator",
	-- 		name = {
	-- 			"firefox1",
	-- 			"firefox2",
	-- 			"chrome"
	-- 		} -- use rule_any in parent dict if using multiple entries in a value
	-- 	},
	-- 	properties = {tag = "2"}
	-- },

	{
		rule = {
			class = "zen"
		},
		properties = { tag = "2" }
	},
	{
		rule = {
			class = "discord"
		},
		properties = { tag = "5" }
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
