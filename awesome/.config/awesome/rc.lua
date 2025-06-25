-- GO TO LINE FOR CHANGING CONFIGURATION

pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- require("awful.hotkeys_popup.keys")

awful.spawn.with_shell("pgrep -x gammastep || gammastep -l 19.07:72.87 -t 6500K:4500K &")
awful.spawn.with_shell("pgrep -x picom || picom --config ~/.config/picom/picom.conf")
awful.spawn.with_shell("xset r rate 300 50")
awful.spawn.with_shell("flameshot")

-- {{{ Error handling
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
		title = "oops, there were errors during startup!",
		text = awesome.startup_errors })
end
-- Handle runtime errors after startup
do
	local in_error = false
	awesome.connect_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
			title = "oops, an error happened!",
			text = tostring(err) })
		in_error = false
	end)
end
-- }}}

-- {{{ Variable definitions
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- modkey = "Mod4" -- super
modkey = "Mod1" -- alt

awful.layout.layouts = {awful.layout.suit.spiral}
-- }}}

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- {{{ test


-- }}}

-- {{{ Wibar

-- Create a textclock widget
mytextclock = wibox.widget.textclock("%I:%M")
-- mysystray = wibox.container.background(wibox.widget.systray(), beautiful.bg_systray)
mysystray = wibox.container.background(
    wibox.widget.systray(),
    beautiful.calert,
    nil,
    { opacity = 0 }
)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({ }, 1, function(t) t:view_only() end),
	awful.button({ modkey }, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({ }, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal(
				"request::activate",
				"tasklist",
				{raise = true}
			)
		end
	end),
	awful.button({ }, 3, function()
		awful.menu.client_list({ theme = { width = 250 } })
	end),
	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
	end),
	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
	end))

local function set_wallpaper(s)
	-- Wallpaper
	if beautiful.wallpaper then
		local wallpaper = beautiful.wallpaper
		-- If wallpaper is a function, call it with the screen
		if type(wallpaper) == "function" then
			wallpaper = wallpaper(s)
		end
		gears.wallpaper.maximized(wallpaper, s, true)
	end
end

-- create a wifi widget
local wifi_widget = wibox.widget {
	widget = wibox.widget.textbox,
	align = 'center'
}
local function update_wifi()
	awful.spawn.easy_async_with_shell(
		"iwctl station wlan0 show | grep 'Connected network' | awk '{print $3}'",
		-- "nmcli -t -f WIFI g | grep -q enabled && nmcli -t -f ACTIVE,SSID dev wifi | grep '^yes' | cut -d: -f2 || echo 'disconnected'",
		function(stdout)
			local ssid = stdout:match("^%s*(.-)%s*$")
			-- wifi_widget.text = ssid ~= "" and (ssid) or "no-internet"
			wifi_widget.markup = (ssid ~= "" and (ssid)
			or ("<span foreground='%s'>%s</span>"):format(beautiful.calert, "no-internet")
		)
			-- wifi_widget.text = "Wifi: " .. stdout:gsub("\n", "")
		end
	)
end
gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = update_wifi()
}
update_wifi()

-- create volume widget
local volume_widget = wibox.widget {
	widget = wibox.widget.textbox,
	align = 'center',
	valign = 'center'
}
local function update_volume()
	awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
		-- local vol_str, mute = stdout:match("Volume:%s+([%d%.]+)%s+%[([%u]*)%]")
		-- local vol = tonumber(vol_str)
		local vol = tonumber(stdout:match("Volume:%s+([%d%.]+)"))
		local volume = ("%d%%"):format(math.floor(vol * 100))
		local mute = stdout:match("%[([%u]+)%]")
		if mute == "MUTED" then
			volume_widget.markup = "<span foreground='"..beautiful.cred.."'>"..volume.."</span>"
		elseif vol then
			volume_widget.text = volume
		else
			volume_widget.text = "Vol: ?"
		end
	end)
end
awesome.connect_signal("volume::update", update_volume)
update_volume()

-- battery widget
local battery_widget = wibox.widget {
	widget = wibox.widget.textbox,
	align = 'center',
	valign = 'center'
}
local function update_battery()
	awful.spawn.easy_async_with_shell(
		"cat /sys/class/power_supply/BAT0/capacity && cat /sys/class/power_supply/BAT0/status",
		function(stdout)
			local lines = {}
			for line in stdout:gmatch("[^\r\n]+") do table.insert(lines, line) end
			local percent = tonumber(lines[1])
			local status = lines[2]

			local color = beautiful.csecondary
			if status == "Charging" then
				color = beautiful.charging
			elseif percent and percent < 20 then
				color = beautiful.alert
			end

			battery_widget.markup = "<span foreground='" .. color .. "'>" .. (percent or "?") .. "%</span>"
		end
	)
end
gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = update_battery
}
update_battery()

-- bluetooth widget
local bluetooth_widget = wibox.widget {
    widget = wibox.widget.textbox,
    align = 'center',
    valign = 'center'
}
local function update_bluetooth()
    awful.spawn.easy_async_with_shell(
        "bluetoothctl info | grep 'Name:' | awk -F': ' '{print $2}'",
        function(stdout)
            local name = stdout:match("^%s*(.-)%s*$")
            if name ~= "" then
                bluetooth_widget.text = name
            else
                bluetooth_widget.text = ""
            end
        end
    )
end
gears.timer {
    timeout = 60,
    autostart = true,
    call_now = true,
    callback = update_bluetooth()
}
update_bluetooth()

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
	-- Wallpaper
	set_wallpaper(s)

	-- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5" }, s, awful.layout.layouts[1])
	-- 

	-- Create a promptbox for each screen
	s.mypromptbox = awful.widget.prompt()
	-- Create an imagebox widget which will contain an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	s.mylayoutbox = awful.widget.layoutbox(s)
	s.mylayoutbox:buttons(gears.table.join(
		awful.button({ }, 1, function () awful.layout.inc( 1) end),
		awful.button({ }, 3, function () awful.layout.inc(-1) end),
		awful.button({ }, 4, function () awful.layout.inc( 1) end),
		awful.button({ }, 5, function () awful.layout.inc(-1) end)))
	-- Create a taglist widget
	s.mytaglist = awful.widget.taglist {
		screen  = s,
		filter  = awful.widget.taglist.filter.noempty,
		buttons = taglist_buttons,
	}

	-- Create the wibox
	s.mywibox = awful.wibar({
		bg = beautiful.cbackground .. beautiful.ctransparency,
		screen = s,
		-- position = 'top',
		x = 100,
		y = 8,
		height = beautiful.wibarHeight,
		-- width = s.geometry.width - beautiful.borderGap*2,
		width = s.geometry.width,
		-- ontop = false,
		-- stretch = false,
	})

	-- Add widgets to the wibox
	local sep = wibox.widget {
		{
			markup = " | ",
			widget = wibox.widget.textbox
		},
		fg = beautiful.cprimary,
		widget = wibox.container.background
	}
	s.mywibox:setup {
		layout = wibox.layout.align.horizontal,
		{ -- Left widgets
			layout = wibox.layout.fixed.horizontal,
			-- mylauncher,
			wibox.widget.textbox(' '),
			s.mytaglist,
			s.mypromptbox,
		},
		-- s.mytasklist, -- Middle widget
		nil,
		{ -- Right widgets
			layout = wibox.layout.fixed.horizontal,
			-- mykeyboardlayout,
			mysystray,
			sep,
			bluetooth_widget,
			sep,
			wifi_widget,
			sep,
			volume_widget,
			sep,
			battery_widget,
			sep,
			mytextclock,
			wibox.widget.textbox(' ')
			-- s.mylayoutbox,
		}
	}
end)
-- }}}

-- {{{ Mouse bindings
-- root.buttons(gears.table.join(
--     awful.button({ }, 3, function () mymainmenu:toggle() end),
--     awful.button({ }, 4, awful.tag.viewnext),
--     awful.button({ }, 5, awful.tag.viewprev)
-- ))
-- }}}

-- {{{ Key bindings keybinds 
globalkeys = gears.table.join(

	-- show/hide wibox
	awful.key({ modkey }, "b", function ()
		for s in screen do
			s.mywibox.visible = not s.mywibox.visible
			if s.mybottomwibox then
				s.mybottomwibox.visible = not s.mybottomwibox.visible
			end
		end
	end,
		{description = "toggle wibox", group = "awesome"}),
	awful.key({ modkey, "Shift"}, "b", function()
		update_bluetooth()
		update_volume()
		update_battery()
		update_wifi()
	end, {description = "refresh wibox widgets", group = "awesome"}),


	-- volumne control shit
	awful.key({}, "XF86AudioLowerVolume", function()
		awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", false)
		awesome.emit_signal("volume::update")
	end, {description = "decrease by 5%", group = "audio"}),
	awful.key({}, "XF86AudioRaiseVolume", function()
		awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
			local vol = tonumber(stdout:match("(%d+%.?%d*)"))
			if vol and vol < 1.0 then
				awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+", false)
				awesome.emit_signal("volume::update")
			end
		end)
	end, {description = "increase by 5%", group = "audio"}),
	awful.key({}, "XF86AudioMute", function()
		awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
		awesome.emit_signal("volume::update")
	end, {description = "toggle mute", group = "audio"}),

	-- brightnessctl shit
	awful.key({}, "XF86MonBrightnessDown", function()
		awful.spawn("brightnessctl set 5%-", false)
	end, {description = "decrease by 5%", group = "misc"}),
	awful.key({}, "XF86MonBrightnessUp", function()
		awful.spawn("brightnessctl set 5%+", false)
	end, {description = "increase by 5%", group = "misc"}),

	-- flameshot
	-- Fullscreen to clipboard
	awful.key({}, "Print", function()
		awful.spawn("flameshot gui")
	end, {description = "flameshot gui", group = "screenshot"}),
	-- Region to clipboard
	awful.key({"Shift"}, "Print", function()
		awful.spawn("flameshot fullscreen to clipboard")
	end, {description = "screenshot region to clipboard", group = "screenshot"}),

	-- others
	awful.key({ "Control", "Shift", "Mod4", "Mod1" }, "s",      hotkeys_popup.show_help,
		{description="show help", group="awesome"}),
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
		{description = "go back", group = "tag"}),

	awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end,
		{description = "focus next by index", group = "client"}),
	awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end,
		{description = "focus previous by index", group = "client"}),

	-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
		{description = "swap with next client by index", group = "client"}),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
		{description = "swap with previous client by index", group = "client"}),

	-- awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
	--           {description = "focus the next screen", group = "screen"}),
	-- awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
	--           {description = "focus the previous screen", group = "screen"}),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
		{description = "jump to urgent client", group = "client"}),
	awful.key({ modkey,           }, "l",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
		end,
		{description = "go back", group = "client"}),

	-- Standard program
	awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
		{description = "open a terminal", group = "launcher"}),
	awful.key({ modkey, "Control" }, "r", awesome.restart,
		{description = "reload awesome", group = "awesome"}),
	awful.key({ modkey, "Shift"   }, "q", awesome.quit,
		{description = "quit awesome", group = "awesome"}),


	-- Prompt
	awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
		{description = "run prompt", group = "launcher"}),

	-- awful.key({ modkey }, "x",
	--           function ()
	--               awful.prompt.run {
	--                 prompt       = "Run Lua code: ",
	--                 textbox      = awful.screen.focused().mypromptbox.widget,
	--                 exe_callback = awful.util.eval,
	--                 history_path = awful.util.get_cache_dir() .. "/history_eval"
	--               }
	--           end,
	--           {description = "lua execute prompt", group = "awesome"}),
	-- Menubar
	awful.key({ modkey }, "p", function() menubar.show() end,
		{description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
	awful.key({ modkey,           }, "m",
		function (c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end,
		{description = "toggle fullscreen", group = "client"}),
	awful.key({ modkey, }, "c",      function (c) c:kill()                         end,
		{description = "close", group = "client"}),
	-- awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
	--           {description = "toggle floating", group = "client"}),
	awful.key({ modkey,           }, "h", function (c) c:swap(awful.client.getmaster()) end,
		{description = "move to master", group = "client"})
	-- awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
	--           {description = "move to screen", group = "client"}),
	-- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
	--           {description = "toggle keep on top", group = "client"}),
	-- awful.key({ modkey,           }, "n",
	--     function (c)
	--         -- The client currently has the input focus, so it cannot be
	--         -- minimized, since minimized clients can't have the focus.
	--         c.minimized = true
	--     end ,
	--     {description = "minimize", group = "client"}),
	-- awful.key({ modkey,           }, "m",
	--     function (c)
	--         c.maximized = not c.maximized
	--         c:raise()
	--     end ,
	--     {description = "(un)maximize", group = "client"}),
	-- awful.key({ modkey, "Control" }, "m",
	--     function (c)
	--         c.maximized_vertical = not c.maximized_vertical
	--         c:raise()
	--     end ,
	--     {description = "(un)maximize vertically", group = "client"}),
	-- awful.key({ modkey, "Shift"   }, "m",
	--     function (c)
	--         c.maximized_horizontal = not c.maximized_horizontal
	--         c:raise()
	--     end ,
	--     {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local keysforworkspaces = { 'a', 's', 'd', 'f', 'g' }
for i, key in ipairs(keysforworkspaces) do
	globalkeys = gears.table.join(globalkeys,
		-- View tag only.
		awful.key({ modkey }, keysforworkspaces[i],
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					tag:view_only()
				end
			end,
			{description = "view tag #"..i, group = "tag"}),
		-- Toggle tag display.
		awful.key({ modkey, "Control" }, keysforworkspaces[i],
			function ()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				if tag then
					awful.tag.viewtoggle(tag)
				end
			end,
			{description = "toggle tag #" .. i, group = "tag"}),
		-- Move client to tag.
		awful.key({ modkey, "Shift" }, keysforworkspaces[i],
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:move_to_tag(tag)
					end
				end
			end,
			{description = "move focused client to tag #"..i, group = "tag"}),
		-- Toggle tag on focused client.
		awful.key({ modkey, "Control", "Shift" }, keysforworkspaces[i],
			function ()
				if client.focus then
					local tag = client.focus.screen.tags[i]
					if tag then
						client.focus:toggle_tag(tag)
					end
				end
			end,
			{description = "toggle focused client on tag #" .. i, group = "tag"})
	)
end

clientbuttons = gears.table.join(
	awful.button({ }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
	end),
	awful.button({ modkey }, 1, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.move(c)
	end),
	awful.button({ modkey }, 3, function (c)
		c:emit_signal("request::activate", "mouse_click", {raise = true})
		awful.mouse.client.resize(c)
	end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
	-- All clients will match this rule.
	{ rule = { },
		properties = { border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = awful.client.focus.filter,
			raise = true,
			keys = clientkeys,
			buttons = clientbuttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_overlap+awful.placement.no_offscreen
		}
	},

	-- Floating clients.
	{ rule_any = {
		instance = {
			"DTA",  -- Firefox addon DownThemAll.
			"copyq",  -- Includes session name in class.
			"pinentry",
		},
		class = {
			"Arandr",
			"Blueman-manager",
			"Gpick",
			"Kruler",
			"MessageWin",  -- kalarm.
			"Sxiv",
			"Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
			"Wpa_gui",
			"veromix",
			"xtightvncviewer"},

		-- Note that the name property shown in xprop might be set slightly after creation of the client
		-- and the name shown there might not match defined rules here.
		name = {
			"Event Tester",  -- xev.
		},
		role = {
			"AlarmWindow",  -- Thunderbird's calendar.
			"ConfigManager",  -- Thunderbird's about:config.
			"pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
		}
	}, properties = { floating = true }},

	-- Add titlebars to normal clients and dialogs
	-- { rule_any = {type = { "normal", "dialog" }
	--   }, properties = { titlebars_enabled = false }
	-- },

	-- Set Firefox to always map on the tag named "2" on screen 1.
	-- { rule = { class = "Firefox" },
	--   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
	-- Set the windows at the slave,
	-- i.e. put it at the end of others instead of setting it master.
	-- if not awesome.startup then awful.client.setslave(c) end

	if awesome.startup
		and not c.size_hints.user_position
		and not c.size_hints.program_position then
		-- Prevent clients from being unreachable after screen count changes.
		awful.placement.no_offscreen(c)
	end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
-- client.connect_signal("request::titlebars", function(c)
--     -- buttons for the titlebar
--     local buttons = gears.table.join(
--         awful.button({ }, 1, function()
--             c:emit_signal("request::activate", "titlebar", {raise = true})
--             awful.mouse.client.move(c)
--         end),
--         awful.button({ }, 3, function()
--             c:emit_signal("request::activate", "titlebar", {raise = true})
--             awful.mouse.client.resize(c)
--         end)
--     )
--
--     awful.titlebar(c) : setup {
--         { -- Left
--             awful.titlebar.widget.iconwidget(c),
--             buttons = buttons,
--             layout  = wibox.layout.fixed.horizontal
--         },
--         { -- Middle
--             { -- Title
--                 align  = "center",
--                 widget = awful.titlebar.widget.titlewidget(c)
--             },
--             buttons = buttons,
--             layout  = wibox.layout.flex.horizontal
--         },
--         { -- Right
--             awful.titlebar.widget.floatingbutton (c),
--             awful.titlebar.widget.maximizedbutton(c),
--             awful.titlebar.widget.stickybutton   (c),
--             awful.titlebar.widget.ontopbutton    (c),
--             awful.titlebar.widget.closebutton    (c),
--             layout = wibox.layout.fixed.horizontal()
--         },
--         layout = wibox.layout.align.horizontal
--     }
-- end)

-- Enable sloppy focus, so that focus follows mouse.
-- client.connect_signal("mouse::enter", function(c)
--     c:emit_signal("request::activate", "mouse_enter", {raise = false})
-- end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
