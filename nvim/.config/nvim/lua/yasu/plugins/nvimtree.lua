--NOTE: keybinds at the bottom
return {
	"nvim-tree/nvim-tree.lua",
	enabled = false,
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			-- auto_reload_on_write = true,
			-- create_in_closed_folder = false,
			-- respect_buf_cwd = false,
			-- sync_root_with_cwd = false,
			-- reload_on_bufenter = false,
			-- select_prompts = false,

			view = {
				adaptive_size = true,
				-- centralize_selection = true,
				width = 25,
				-- hide_root_folder = false,
				side = "right",
				-- preserve_window_proportions = false,
				-- number = false,
				-- relativenumber = false,
				signcolumn = "no",
				-- float = {
				-- 	enable = false,
				-- 	quit_on_focus_loss = true,
				-- 	open_win_config = {
				-- 		relative = "editor",
				-- 		border = "rounded",
				-- 		width = 30,
				-- 		height = 30,
				-- 		row = 1,
				-- 		col = 1,
				-- 	},
				-- },
			},

			renderer = {
				-- add_trailing = false,
				group_empty = false,
				highlight_git = false,
				full_name = false,
				highlight_opened_files = "none",
				root_folder_modifier = ":~",
				indent_markers = {
					enable = true,
					inline_arrows = true,
					icons = {
						corner = "└ ",
						edge = "│ ",
						item = "│ ",
						bottom = "─ ",
						none = "  ",
					},
				},
				icons = {
					webdev_colors = true,
					git_placement = "before",
					padding = " ",
					symlink_arrow = " -> ",
					show = {
						file = true,
						folder = true,
						folder_arrow = true,
						git = true,
					},
					glyphs = {
						default = "",
						symlink = "",
						folder = {
							-- arrow_closed = "",
							arrow_closed = "",
							-- arrow_open = "",
							arrow_open = "",
							default = "",
							open = "",
							empty = "",
							empty_open = "",
							symlink = "",
							symlink_open = "",
						},
						git = {
							unstaged = "✗",
							staged = "✓",
							unmerged = "",
							renamed = "➜",
							untracked = "★",
							deleted = "",
							ignored = "◌",
						},
					},
				},
			},

			update_focused_file = {
				enable = false,
				update_root = false,
				ignore_list = {},
			},

			diagnostics = {
				enable = true,
				show_on_dirs = false,
				show_on_open_dirs = true,
				debounce_delay = 50,
				severity = {
					min = vim.diagnostic.severity.HINT,
					max = vim.diagnostic.severity.ERROR,
				},
				icons = {
					hint = "",
					info = "",
					warning = "",
					error = "",
				},
			},

			filters = {
				dotfiles = false,
				git_clean = false,
				no_buffer = false,
				custom = {},
				exclude = {},
			},

			git = {
				enable = true,
				ignore = false,
				show_on_dirs = true,
				show_on_open_dirs = true,
				timeout = 400,
			},

			actions = {
				use_system_clipboard = true,
				change_dir = {
					enable = true,
					global = false,
					restrict_above_cwd = false,
				},
				expand_all = {
					max_folder_discovery = 300,
					exclude = {},
				},
				file_popup = {
					open_win_config = {
						col = 1,
						row = 1,
						relative = "cursor",
						border = "shadow",
						style = "minimal",
					},
				},
				open_file = {
					quit_on_open = false,
					resize_window = true,
					window_picker = {
						enable = true,
						picker = "default",
						chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
						exclude = {
							filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
							buftype = { "nofile", "terminal", "help" },
						},
					},
				},
				remove_file = {
					close_window = true,
				},
			},

			trash = {
				cmd = "gio trash",
				require_confirm = true,
			},

			log = {
				enable = false,
				truncate = false,
				types = {
					all = false,
					config = false,
					copy_paste = false,
					dev = false,
					diagnostics = false,
					git = false,
					profile = false,
					watcher = false,
				},
			},
		})

		vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle, { desc = '[P] toggle nvim-tree' })
		vim.keymap.set("n", "<leader>E", vim.cmd.NvimTreeFindFileToggle, { desc = '[P] find current file in nvim-tree' })
	end,
}
