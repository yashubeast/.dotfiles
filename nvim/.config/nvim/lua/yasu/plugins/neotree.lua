-- https://github.com/nvim-neo-tree/neo-tree.nvim
return {
	"nvim-neo-tree/neo-tree.nvim",
	enabled = true,
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	lazy = false, -- neo-tree will lazily load itself
	config = function()
		require("neo-tree").setup({
			sources = { "filesystem", "buffers", "git_status" },
			window = {
				position = "right",
				width = 25,
				-- mappings = {
				-- 	["<space>"] = "toggle_node"
				-- }
			},
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					-- show_hidden_count = true,
				},
			},
			default_component_configs = {
				indent = {
					with_markers = true,
					with_expanders = true
				},
				git_status = {
					symbols = {
						added     = "",
						modified  = "",
						deleted   = "",
						renamed   = "",
						untracked = "",
						ignored   = "",
						unstaged  = "",
						staged    = "",
						conflict  = "",
					},
					highlight = true,
				}
			},
			enable_git_status = true,
			enable_diagnostics = false
		})
		vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = '[P] toggle neo-tree' })
		vim.keymap.set("n", "<leader>E", ":Neotree reveal<CR>", { desc = '[P] reveal current file in neo-tree' })

		vim.cmd [[
			highlight NeoTreeGitAdded     guifg=#9ece6a
			highlight NeoTreeGitModified  guifg=#e0af68
			highlight NeoTreeGitDeleted   guifg=#f7768e
			highlight NeoTreeGitRenamed   guifg=#7aa2f7
			highlight NeoTreeGitUntracked guifg=#e0af68
			highlight NeoTreeGitIgnored   guifg=#5c6370
			highlight NeoTreeGitStaged    guifg=#9ece6a
			highlight NeoTreeGitConflict  guifg=#ff9e64

			"highlight NeoTreeDirectoryName guifg=#f7768e
			"highlight NeoTreeDirectoryIcon guifg=#f7768e
		]]
	end
}
