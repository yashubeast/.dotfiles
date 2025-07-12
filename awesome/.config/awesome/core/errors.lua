local naughty = require("naughty")

-- Startup errors
if awesome.startup_errors then
	naughty.notify({
		preset = naughty.config.presets.critical,
		title = "oops, there were errors during startup!",
		text = awesome.startup_errors
	})
end

-- Runtime errors
do
	local in_error = false
	awesome.connect_signal("debug::error", function(err)
		if in_error then return end
		in_error = true

		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "oops, an error happened!",
			text = tostring(err)
		})
		in_error = false
	end)
end
