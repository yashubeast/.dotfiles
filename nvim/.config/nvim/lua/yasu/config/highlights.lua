-- Require the colors.lua module and access the colors directly without

local C = require("yasu.config.colors")
local fg = vim.g.md_heading_bg == 'transparent'
	and C['linkarzu_color13']
	or C['linkarzu_color26']

local bgs = {
	C["linkarzu_color04"],
	C["linkarzu_color02"],
	C["linkarzu_color03"],
	C["linkarzu_color01"],
	C["linkarzu_color05"],
	C["linkarzu_color08"],
}

for i, bg in ipairs(bgs) do
	vim.api.nvim_set_hl(0, ("@markup.heading.%d.markdown"):format(i), {
		-- bold = true,
		fg = fg,
		bg = bg,
	})
end

