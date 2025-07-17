return {
	'epwalsh/obsidian.nvim',
	enabled = true,
	version = '*',
	lazy = true,
	ft = 'markdown',
	dependencies = {
		'nvim-lua/plenary.nvim',
	},
	opts = {
		workspaces = {
			{
				name = 'obs',
				path = vim.g.obsidian_path,
			},
		},
		mappings = {
			-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
			["gf"] = {
				action = function()
					return require("obsidian").util.gf_passthrough()
				end,
				opts = { noremap = false, expr = true, buffer = true },
			},
		},
		disable_frontmatter = true,
		ui = {
			enable = false,
			checkboxes = {
				[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
				["x"] = { char = "", hl_group = "ObsidianDone" },
				-- ["~"] = { char = "󰥔", hl_group = "ObsidianTilde" },
				-- ["!"] = { char = "", hl_group = "ObsidianImportant" },
			},
			bullets = { char = "", hl_group = "ObsidianBullet" },
			hl_groups = {
				-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
				ObsidianTodo = { bold = true, fg = "#f78c6c" },
				ObsidianDone = { bold = true, fg = "#89ddff" },
				ObsidianTilde = { bold = true, fg = "#f78c6c" },
				ObsidianImportant = { bold = true, fg = "#d73128" },
				ObsidianBullet = { bold = true, fg = "#89ddff" },
				ObsidianRefText = { underline = true, fg = "#c792ea" },
				ObsidianExtLinkIcon = { fg = "#c792ea" },
				-- ObsidianTag = { italic = true, fg = "#89ddff" },
				ObsidianBlockID = { italic = true, fg = "#89ddff" },
				ObsidianHighlightText = { bg = "#75662e" },
			},
		},
	},
	init = function()
		vim.api.nvim_create_autocmd('FileType', {
			pattern = 'markdown',
			callback = function()
				local opt = vim.opt_local

				-- opt.conceallevel = 0
				opt.foldmethod = "expr"
				opt.foldexpr = "nvim_treesitter#foldexpr()"
				opt.foldenable = true

				-- keybinds
				local opts = {buffer = true, silent = true}
				local km = vim.keymap.set

				-- km({ "n", "v" }, "gj", "]]", {desc = "[P] go to next markdown header"})
				-- km({ "n", "v" }, "gk", "[[", {desc = "[P] go to previous markdown header"})

				km("n", "mf1", function() opt.foldlevel = 0  end, {desc = "[P] view heading 1"})
				km("n", "mf2", function() opt.foldlevel = 1  end, {desc = "[P] view heading 2"})
				km("n", "mf3", function() opt.foldlevel = 2  end, {desc = "[P] view heading 3"})
				km("n", "mf4", function() opt.foldlevel = 3  end, {desc = "[P] view heading 4"})
				km("n", "mf5", function() opt.foldlevel = 4  end, {desc = "[P] view heading 5"})
				km("n", "mf6", function() opt.foldlevel = 5  end, {desc = "[P] view heading 6"})
				km("n", "<CR>", "zA", {desc = "[P] toggle all folds under cursor"})
				km("n", "mff", "zM", {desc = "[P] fold all headings"})
				km("n", "mfu", "zR", {desc = "[P] unfold all headings"})
				km("n", "mc", "<cmd>ObsidianToggleCheckbox<CR>", {desc = "[P] create/toggle checkbox"})

				-- bullet toggle
				km("n", "mb", function()
					local line = vim.api.nvim_get_current_line()
					if line:match("^%s*%- ") then
						-- remove bullet
						local new_line = line:gsub("^%s*%- ", "", 1)
						vim.api.nvim_set_current_line(new_line)
					else
						-- add bullet
						vim.api.nvim_set_current_line("- " .. line)
					end
				end, { desc = "[P] toggle bullet" })

				-- end of shit
			end
		})
	end
}
