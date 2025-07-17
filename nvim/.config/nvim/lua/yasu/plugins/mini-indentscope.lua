-- https://github.com/echasnovski/mini.indentscope
--
-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/mini-indentscope.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/mini-indentscope.lua
--
-- This plugins shows you a vertical colored line that allows you to see the
-- scope of your indentations

return {
	"echasnovski/mini.indentscope",
	version = false, -- wait till new 0.7.0 release to put it back on semver
	enabled = false,
	-- event = "LazyFile",
	opts = {
		mappings = {
			object_scope = '',
			object_scope_with_border = '',
			goto_top = '',
			goto_bottom = '',
		},
		draw = {
			animation = function()
				return 0
			end
		},
		symbol = "▏",
		-- symbol = "│",
		options = {
			try_as_border = true,
			border = "both",
			indent_at_cursor = false,
		},
	},
	init = function()
		vim.api.nvim_create_autocmd("FileType", {
			pattern = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
			},
			callback = function()
				vim.b.miniindentscope_disable = true
			end,
		})
	end,
}
