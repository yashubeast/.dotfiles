-- Widgets, wibox, and screen bar layout

-- Standard awesome libraries
local gears     = require("gears")
local awful     = require("awful")
local wibox     = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful.xresources").apply_dpi
local naughty   = require("naughty")

---------------------------------------------------------------------
-- Wallpaper helper -------------------------------------------------
---------------------------------------------------------------------
local function set_wallpaper(s)
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

---------------------------------------------------------------------
-- Helper to wrap any widget into a rounded box ---------------------
---------------------------------------------------------------------
local boxed_widget_primary = beautiful.wibarBackground
local function boxed_widget(widget, bg_color, fg_color)
	local container = wibox.widget {
		{
			widget,
			left   = 10,
			right  = 10,
			widget = wibox.container.margin,
		},
		bg     = bg_color or boxed_widget_primary,
		fg     = fg_color or beautiful.wibarForeground,
		shape  = gears.shape.rounded_rect,
		widget = wibox.container.background,
	}
	return container

	-- return wibox.widget {
	-- 	container,
	-- 	set_bg = function(self, color)
	-- 		container.bg = color
	-- 	end,
	-- 	get_bg = function()
	-- 		return container.bg
	-- 	end,
	-- 	layout = wibox.layout.fixed.horizontal
	-- }
end

---------------------------------------------------------------------
-- Widgets ----------------------------------------------------------
---------------------------------------------------------------------

-- Clock ------------------------------------------------------------
local mytextclock = boxed_widget(
	wibox.widget.textclock("%I:%M")
)

-- Systray ----------------------------------------------------------
local mysystray_raw = wibox.container.background(
	wibox.widget.systray(),
	beautiful.alert,
	nil,
	{ opacity = 0 }
)
local mysystray = boxed_widget(mysystray_raw)

-- Wifi widget ------------------------------------------------------
local wifi_widget_raw = wibox.widget {
	widget = wibox.widget.textbox,
	align  = "center",
}
local wifi_widget = boxed_widget(wifi_widget_raw)

local function update_wifi()
	awful.spawn.easy_async_with_shell(
		"iwctl station wlan0 show | grep 'Connected network' | awk '{print $3}'",
		function(stdout)
			local ssid = stdout:match("^%s*(.-)%s*$")
			if ssid ~= "" then
				wifi_widget_raw.markup = "󰤨 " .. ssid
				wifi_widget.bg = boxed_widget_primary
			else
				wifi_widget_raw.markup = "󰤯"
				wifi_widget.bg = beautiful.alert
			end
		end
	)
end
gears.timer({ timeout = 60, autostart = true, call_now = true, callback = update_wifi })

-- Volume widget ----------------------------------------------------
local volume_widget_raw = wibox.widget {
	widget = wibox.widget.textbox,
	align  = "center",
	valign = "center",
}
local volume_widget = boxed_widget(volume_widget_raw)

local function update_volume()
	awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
		local vol  = tonumber(stdout:match("Volume:%s+([%d%.]+)"))
		local mute = stdout:match("%[([%u]+)%]")
		-- local volume = vol and ("%d%%"):format(math.floor(vol * 100)) or "?"
		local volume = vol and tostring(math.floor(vol * 100)) or "?"
		local icon = "x"

		if mute == "MUTED" then
			-- volume_widget_raw.markup = volume
			volume_widget.bg = beautiful.alert
			icon = " "
		else
			-- volume_widget_raw.text = icon .. volume
			volume_widget.bg = boxed_widget_primary
			icon = " "
		end
		volume_widget_raw.text = icon .. volume
	end)
end
awesome.connect_signal("volume::update", update_volume)
gears.timer({ timeout = 60, autostart = true, call_now = true, callback = update_volume })

-- Battery widget ---------------------------------------------------
local battery_widget_raw = wibox.widget {
	widget = wibox.widget.textbox,
	align  = "center",
	valign = "center",
}
local battery_widget = boxed_widget(battery_widget_raw)

local function update_battery()
	awful.spawn.easy_async_with_shell(
		"cat /sys/class/power_supply/BAT0/capacity && cat /sys/class/power_supply/BAT0/status",
		function(stdout)
			local lines   = {}
			for line in stdout:gmatch("[^\r\n]+") do table.insert(lines, line) end
			local percent = tonumber(lines[1])
			local status  = lines[2]
			local color   = boxed_widget_primary
			local icon = " "

			status = status:lower()
			if status == "charging" or status == "full" then
				color = beautiful.charging
			elseif percent and percent <= 20 then
				naughty.notify({ text = "battery low" })
				color = beautiful.alert
			end

			battery_widget_raw.text = icon .. (percent and tostring(percent) or "?")
			if color then
				battery_widget.bg = color
			end
		end
	)
end
gears.timer({ timeout = 60, autostart = true, call_now = true, callback = update_battery })

-- Bluetooth widget -------------------------------------------------
local bluetooth_widget_raw = wibox.widget {
	widget = wibox.widget.textbox,
	align  = "center",
	valign = "center",
}
local function update_bluetooth()
	awful.spawn.easy_async_with_shell(
		"bluetoothctl info | grep 'Name:' | awk -F': ' '{print $2}'",
		function(stdout)
			local name = stdout:match("^%s*(.-)%s*$")
			bluetooth_widget_raw.text = (name ~= "" and name) or "󰂯"
		end
	)
end
gears.timer({ timeout = 60, autostart = true, call_now = true, callback = update_bluetooth })
local bluetooth_widget = boxed_widget(bluetooth_widget_raw)

---------------------------------------------------------------------
-- Screen setup -----------------------------------------------------
---------------------------------------------------------------------

-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- set_wallpaper(s)

	-- Tags ---------------------------------------------------------
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])

	-- Taglist ------------------------------------------------------
	
	local function taglist_box(tag)
		local text = wibox.widget {
			text   = tag.name,
			align  = "center",
			valign = "center",
			widget = wibox.widget.textbox,
		}
		local color
		if tag.urgent then
			color = beautiful.alert
		elseif tag.selected then
			color = boxed_widget_primary
		else
			color = beautiful.disabled
		end

		local box = boxed_widget(text)
		box.bg = color
		return wibox.widget {
			box,
			left = beautiful.wibarWorkspaceGap,
			right = beautiful.wibarWorkspaceGap,
			widget = wibox.container.margin
		}
	end

	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.noempty,
		layout = wibox.layout.fixed.horizontal,
		-- spacing = dpi(50),
		widget_template = {
			create_callback = function(self, tag)
				self:reset()
				self:set_widget(taglist_box(tag))
			end,
			update_callback = function(self, tag)
				self:reset()
				self:set_widget(taglist_box(tag))
			end,
			widget = wibox.container.place,
		},
	}

	-- Bar geometry -------------------------------------------------
	local gap = (beautiful.wibarGapBool and beautiful.wibarGap or 0)
	s.mywibox = wibox {
		bg     = (beautiful.wibarBackground or "#ff0000") .. (beautiful.wibartransparency or "ff"),
		screen = s,
		x      = gap,
		y      = gap,
		height = beautiful.wibarHeight,
		width  = s.geometry.width - gap * 2,
		ontop  = true,
	}
	s.mywibox:struts {
		top = beautiful.wibarHeight + (beautiful.wibarGapBool and beautiful.wibarGap or 0)
	}

	-- Separator widget --------------------------------------------
	-- local sep = wibox.widget {
	-- 	{
	-- 		markup = beautiful.wibarSeparator or " | ",
	-- 		widget = wibox.widget.textbox,
	-- 	},
	-- 	fg     = beautiful.primary,
	-- 	widget = wibox.container.background,
	-- }

	-- Mid & right sections ----------------------------------------
	local wiboxMiddle = wibox.widget {
		-- wibox.widget.textbox(beautiful.wibarPadding),
		s.mytaglist,
		layout = wibox.layout.fixed.horizontal,
	}

	local wiboxRight = wibox.widget {
		layout = wibox.layout.fixed.horizontal,
		spacing = beautiful.wibarWidgetGap,
		mysystray,
		bluetooth_widget,
		wifi_widget,
		volume_widget,
		battery_widget,
		mytextclock,
	}

	-- Final bar setup ---------------------------------------------
	s.mywibox:setup {
		layout = wibox.layout.stack,
		{
			wiboxMiddle,
			halign = "center",
			valign = "center",
			widget = wibox.container.place,
		},
		{
			wiboxRight,
			halign = "right",
			valign = "center",
			widget = wibox.container.place,
		},
	}
end)

return {
	battery = update_battery,
	volume = update_volume,
	wifi = update_wifi,
	bluetooth = update_bluetooth
}
