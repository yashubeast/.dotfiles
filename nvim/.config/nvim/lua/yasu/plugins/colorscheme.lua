return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		lazy = false,
		enabled = true,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				term_colors = true,
				styles = {
					comments = {},
					conditionals = {},
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				integrations = {
					lualine = false,
					telescope = true,
					which_key = true,
					treesitter = true,
					gitsigns = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "undercurl" },
							hints = { "undercurl" },
							warnings = { "undercurl" },
							information = { "undercurl" },
						},
					},
				},
				highlight_overrides = {
					mocha = function(colors)
						return {
							StatusLineNC = { fg = colors.overlay0, bg = colors.mantle }
						}
					end,
				}
			})
			vim.cmd.colorscheme("catppuccin")
		end,
	},

	{
		'dylanaraps/wal.vim',
		name = "pywal",
		priority = 1001,
		lazy = false,
		enabled = true,
		config = function()
			vim.opt.termguicolors = true
			vim.cmd.colorscheme("wal")

			local transparent_groups = {
				"Normal",
				"NormalNC",
				"NormalFloat",
				"FloatBorder",
				"SignColumn",
				"VertSplit",
				"StatusLine",
				"StatusLineNC",
				"LineNr",
				"Folded",
				"EndOfBuffer",
			}
			for _, group in ipairs(transparent_groups) do
				vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
			end
		end,
	},

	{
		'nvim-lualine/lualine.nvim',
		lazy = false,
		dependencies = {
			'nvim-tree/nvim-web-devicons'
		},
		config = function()
			require('lualine').setup({
				options = {
					theme = "auto",
					icons_enabled = true,
					-- section_separators = { left = "", right = "" },
					section_separators = '',
					-- component_separators = { left = "", right = "" },
					component_separators = '',
					always_divide_middle = true,
					disabled_filetypes = {},
				},
				sections = {
					-- icon = ''
					-- lualine_a = { {
					-- 	"mode",
					-- 	fmt = function(str)
					-- 		return str:sub(1, 1)
					-- 	end,
					-- } },
					lualine_a = { 'fileformat' },
					lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
					lualine_c = { "filename" },
					lualine_x = { "filetype" },
					lualine_y = {},
					lualine_z = {},
				},
				inactive_sections = {
					lualine_a = {},
					lualine_b = {},
					lualine_c = { 'filename' },
					lualine_x = {},
					lualine_y = {},
					lualine_z = {},
				},
			})
		end,
	},
}
