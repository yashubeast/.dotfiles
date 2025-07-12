local gears = require("gears")
local beautiful = require("beautiful")

-- theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "core/theme.lua")

-- terminal, editor, modkey
terminal = beautiful.terminal or "xterm"
editor = beautiful.editor or os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- set default terminal for menubar
-- local menubar = require("menubar")
-- menubar.utils.terminal = terminal
