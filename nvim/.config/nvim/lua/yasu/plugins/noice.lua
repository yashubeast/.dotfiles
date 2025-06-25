return {
	'folke/noice.nvim',
	event = 'VeryLazy',
	dependencies = {
		'MunifTanjim/nui.nvim',
		'rcarriga/nvim-notify',
	},

	config = function()

		math.randomseed(os.time())

		local function random_greeting()
			local greetings = vim.g.greetings or {' cmdline '}
			return greetings[math.random(#greetings)]
		end

		require('noice').setup({
			views = {
				cmdline_popup = {
					border = {
						style = "rounded",
						padding = { 0, 1 },
					},
				},
				popupmenu = {
					backend = "blink.cmp", -- uses nvim-cmp for the popup menu
				},
			},
			messages = {
				enabled = true,
				view = 'mini',
				view_error = 'mini',
				view_warn = 'mini',
				view_history = 'mini',
				-- view_search = 'mini',
			},
			notify = {
				enabled = true,
				view = 'mini',
			},
			cmdline = {
				format = {
					cmdline = { title = random_greeting() },
					search_down = { title = random_greeting() },
					search_up = { title = random_greeting() },
					lua = { title = random_greeting() },
					input = { title = random_greeting() },
				},
			},
			lsp = {
				message = {
					enabled = true,
					view = 'mini',
				},
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
				},
			},
			routes = {
				{
					view = 'mini',
					filter = { event = 'msg_showmode' }
				}
			},
		})
	end
}
