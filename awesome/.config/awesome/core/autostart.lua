local awful = require("awful")

awful.spawn.with_shell("pgrep -x gammastep || gammastep -l 19.07:72.87 -t 6500K:4500K &")
awful.spawn.with_shell("pgrep -x picom || picom --config ~/.config/picom/picom.conf")
awful.spawn.with_shell("xset r rate 300 50")
awful.spawn.with_shell("flameshot")
