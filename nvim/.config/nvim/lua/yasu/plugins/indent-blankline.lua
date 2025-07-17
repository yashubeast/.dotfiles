return {
	"lukas-reineke/indent-blankline.nvim",
	enabled = true,
	main = "ibl",
	---@module "ibl"
	---@type ibl.config

	opts = {
		indent = {
			char = "▏",
			highlight = { "IblIndent" },
		},
		scope = { enabled = false }
	},
	config = function(_, opts)
		local hooks = require("ibl.hooks")
		hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			vim.api.nvim_set_hl(0, "IblIndent", { fg = vim.g.disabled })
		end)

		require("ibl").setup(opts)
	end
}
