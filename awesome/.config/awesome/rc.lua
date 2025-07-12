require("core")

pcall(require, "luarocks.loader")

-- load core modules
require("core.autostart")
require("core.errors")
require("core.vars")
require("core.layouts")
require("core.theme")

-- load ui
require("ui.wibar")

-- load bindings
-- require("bindings.mouse")
require("bindings.keys")

-- load rules and signals
require("core.rules")
require("core.signals")
