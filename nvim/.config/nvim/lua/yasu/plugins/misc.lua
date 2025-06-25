return {
	{
		'NMAC427/guess-indent.nvim',
		event = 'VeryLazy',
	},
	{
		'folke/todo-comments.nvim',
		event = 'VeryLazy',
		dependencies = {
			'nvim-lua/plenary.nvim'
		},
		opts = {
			signs = false,
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			-- cursor_color = '#edddd8'
		}
	},
	{
		"karb94/neoscroll.nvim",
		opts = {},
		config = function()
			local neoscroll = require('neoscroll')
			neoscroll.setup({
				-- mappings = {
				-- 	'<C-u>', '<C-d>',
				-- },
				duration_multiplier = 0.2
			})
			local keymap = {
				["<C-u>"] = function() neoscroll.ctrl_u({ duration = 200; easing = 'circular' }) end;
				["<C-d>"] = function() neoscroll.ctrl_d({ duration = 200; easing = 'circular' }) end;
			}
			local modes = { 'n', 'v', 'x' }
			for key, func in pairs(keymap) do
				vim.keymap.set(modes, key, func)
			end
		end
	},
}
