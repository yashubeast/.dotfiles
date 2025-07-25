---------------------------
-- yasu's awesome theme --
---------------------------

local function ge(var)
    -- local f = io.popen("bash -c 'source ~/.config/yasu/theme/active.sh && echo -n $" .. var .. "'")
    local f = io.popen("bash -c 'source ~/.config/yasu/theme/active.sh && echo -n \"$" .. var .. "\"'")
    local val = f:read("*a")
    f:close()
    return val
end

local naughty = require("naughty")
-- local theme_assets = require("beautiful.theme_assets")
local gfs = require("gears.filesystem")
local gears = require("gears")
-- local themedir = gfs.get_themes_dir()
-- local valPath = gfs.get_configuration_dir()

local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}
local font = ge("awmFont") .. " " .. ge("awmFontSize")

theme.wibarBackground = ge("wibarBackground")
theme.wibarForeground = ge("wibarForeground")
theme.alert = ge("alert")
theme.primary = ge("primary")
theme.secondary = ge("secondary")
theme.disabled = ge("disabled")
theme.wibartransparency = ge("wibartransparency")

theme.white = ge("white")
theme.black = ge("black")
theme.gray = ge("gray")
theme.red = ge("red")
theme.pink = ge("pink")
theme.yellow = ge("yellow")
theme.cyan = ge("cyan")
theme.azure = ge("azure")
theme.lime = ge("lime")

theme.charging = ge("wibarCharging")

-- theme.wallpaper = os.getenv("HOME") .. "/.cache/wal/wal"
theme.wallpaper = ge("wallDir") .. ge("wallFile")
-- naughty.notify({ text = ge("wallpaperDir") })

theme.font          = font
theme.hotkeys_font  = font
theme.hotkeys_description_font  = font

-- theme.bg_normal     = theme.yellow
-- theme.bg_focus      = Yello
-- theme.bg_urgent     = theme.alert
theme.bg_systray    = theme.wibarBackground
-- theme.bg_minimize   = "444444"

-- theme.fg_normal     = theme.secondary
-- theme.fg_focus      = theme.primary
-- theme.fg_urgent     = "ffffff"
-- theme.fg_minimize   = "ffffff"

theme.wibarGap      = ge("wibarGap")
theme.wibarGapBool  = ge("wibarGapBool") == "true"
theme.wibarHeight   = ge("wibarHeight")
-- theme.wibarSeparator= ge("wibarSeparator")
-- theme.wibarPadding  = ge("wibarPadding")
theme.useless_gap   = dpi(theme.wibarGap/2)
theme.wibarWidgetGap= dpi(ge("wibarWidgetGap"))
theme.wibarWorkspaceGap = dpi(ge("wibarWorkspaceGap"))
theme.border_width  = dpi(ge("wibarBorderWidth"))
theme.border_normal = ge("wibarBorderNormal")
theme.border_focus  = ge("wibarBorderFocus")
theme.border_marked = theme.alert

-- theme.taglist_font = valFont
theme.taglist_spacing = theme.wibarWorkspaceGap
-- theme.taglist_shape = gears.shape.circle

theme.terminal      = ge("terminal")
theme.editor        = ge("editor")

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- prompt_[fg|bg|fg_cursor|bg_cursor|font]
-- hotkeys_[bg|fg|border_width|border_color|shape|opacity|modifiers_fg|label_bg|label_fg|group_margin|font|description_font]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Generate taglist squares:
-- local taglist_square_size = dpi(4)
-- theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
--     taglist_square_size, theme.fg_normal
-- )
-- theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
--     taglist_square_size, theme.fg_normal
-- )

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
-- theme.menu_submenu_icon = themes_path.."default/submenu.png"
-- theme.menu_height = dpi(15)
-- theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
-- theme.titlebar_close_button_normal = themes_path.."default/titlebar/close_normal.png"
-- theme.titlebar_close_button_focus  = themes_path.."default/titlebar/close_focus.png"

-- theme.titlebar_minimize_button_normal = themes_path.."default/titlebar/minimize_normal.png"
-- theme.titlebar_minimize_button_focus  = themes_path.."default/titlebar/minimize_focus.png"

-- theme.titlebar_ontop_button_normal_inactive = themes_path.."default/titlebar/ontop_normal_inactive.png"
-- theme.titlebar_ontop_button_focus_inactive  = themes_path.."default/titlebar/ontop_focus_inactive.png"
-- theme.titlebar_ontop_button_normal_active = themes_path.."default/titlebar/ontop_normal_active.png"
-- theme.titlebar_ontop_button_focus_active  = themes_path.."default/titlebar/ontop_focus_active.png"
--
-- theme.titlebar_sticky_button_normal_inactive = themes_path.."default/titlebar/sticky_normal_inactive.png"
-- theme.titlebar_sticky_button_focus_inactive  = themes_path.."default/titlebar/sticky_focus_inactive.png"
-- theme.titlebar_sticky_button_normal_active = themes_path.."default/titlebar/sticky_normal_active.png"
-- theme.titlebar_sticky_button_focus_active  = themes_path.."default/titlebar/sticky_focus_active.png"
--
-- theme.titlebar_floating_button_normal_inactive = themes_path.."default/titlebar/floating_normal_inactive.png"
-- theme.titlebar_floating_button_focus_inactive  = themes_path.."default/titlebar/floating_focus_inactive.png"
-- theme.titlebar_floating_button_normal_active = themes_path.."default/titlebar/floating_normal_active.png"
-- theme.titlebar_floating_button_focus_active  = themes_path.."default/titlebar/floating_focus_active.png"
--
-- theme.titlebar_maximized_button_normal_inactive = themes_path.."default/titlebar/maximized_normal_inactive.png"
-- theme.titlebar_maximized_button_focus_inactive  = themes_path.."default/titlebar/maximized_focus_inactive.png"
-- theme.titlebar_maximized_button_normal_active = themes_path.."default/titlebar/maximized_normal_active.png"
-- theme.titlebar_maximized_button_focus_active  = themes_path.."default/titlebar/maximized_focus_active.png"

-- You can use your own layout icons like this:
-- theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
-- theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
-- theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
-- theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
-- theme.layout_max = themes_path.."default/layouts/maxw.png"
-- theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
-- theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
-- theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
-- theme.layout_tile = themes_path.."default/layouts/tilew.png"
-- theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
-- theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
-- theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
-- theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
-- theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
-- theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
-- theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

-- Generate Awesome icon:
-- theme.awesome_icon = theme_assets.awesome_icon(
--     theme.menu_height, theme.bg_focus, theme.fg_focus
-- )

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
-- theme.icon_theme = nil

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

return theme
