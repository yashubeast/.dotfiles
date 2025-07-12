local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local naughty = require("naughty")
local mywibar = require("ui.wibar")

local modkey = "Mod1"

local globalkeys = gears.table.join(
    awful.key({ modkey }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
                s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
        end
    end, { description = "toggle wibox", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "b", function()
			mywibar.battery()
			mywibar.volume()
			mywibar.wifi()
			mywibar.bluetooth()
    end, { description = "refresh wibox widgets", group = "awesome" }),

    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-", false)
        awesome.emit_signal("volume::update")
    end, { description = "decrease by 5%", group = "audio" }),

    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn.easy_async_with_shell("wpctl get-volume @DEFAULT_AUDIO_SINK@", function(stdout)
            local vol = tonumber(stdout:match("(%d+%.?%d*)"))
            if vol and vol < 1.0 then
                awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+", false)
                awesome.emit_signal("volume::update")
            end
        end)
    end, { description = "increase by 5%", group = "audio" }),

    awful.key({}, "XF86AudioMute", function()
        awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle", false)
        awesome.emit_signal("volume::update")
    end, { description = "toggle mute", group = "audio" }),

    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn("brightnessctl set 5%-", false)
    end, { description = "decrease by 5%", group = "misc" }),

    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn("brightnessctl set 5%+", false)
    end, { description = "increase by 5%", group = "misc" }),

    awful.key({}, "Print", function()
        awful.spawn("flameshot gui")
    end, { description = "flameshot gui", group = "screenshot" }),

    awful.key({ "Shift" }, "Print", function()
        awful.spawn("flameshot fullscreen to clipboard")
    end, { description = "screenshot region to clipboard", group = "screenshot" }),

    awful.key({ "Control", "Shift", "Mod4", "Mod1" }, "s", hotkeys_popup.show_help,
        { description = "show help", group = "awesome" }),

    awful.key({ modkey }, "Escape", awful.tag.history.restore,
        { description = "go back", group = "tag" }),

    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }),

    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),

    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
        { description = "swap with next client by index", group = "client" }),

    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
        { description = "swap with previous client by index", group = "client" }),

    -- awful.key({ modkey }, "u", awful.client.urgent.jumpto,
    --     { description = "jump to urgent client", group = "client" }),

    awful.key({ modkey }, "l", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end, { description = "go back", group = "client" }),

    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        { description = "open a terminal", group = "launcher" }),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey }, "r", function() awful.spawn("rofi -show drun") end,
        { description = "rofi", group = "launcher" })
)

local keysforworkspaces = { 'a', 's', 'd', 'f', 'g' }
for i, key in ipairs(keysforworkspaces) do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, key, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end, { description = "view tag #" .. i, group = "tag" }),

        awful.key({ modkey, "Control" }, key, function()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then awful.tag.viewtoggle(tag) end
        end, { description = "toggle tag #" .. i, group = "tag" }),

        awful.key({ modkey, "Shift" }, key, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end, { description = "move focused client to tag #" .. i, group = "tag" }),

        awful.key({ modkey, "Control", "Shift" }, key, function()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:toggle_tag(tag) end
            end
        end, { description = "toggle focused client on tag #" .. i, group = "tag" })
    )
end

local clientkeys = gears.table.join(
    awful.key({ modkey }, "m", function(c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end, { description = "toggle fullscreen", group = "client" }),

    awful.key({ modkey }, "c", function(c) c:kill() end,
        { description = "close", group = "client" }),

    awful.key({ modkey }, "h", function(c)
        c:swap(awful.client.getmaster())
    end, { description = "move to master", group = "client" })
)

root.keys(globalkeys)

return {
    global = globalkeys,
    client = clientkeys
}
