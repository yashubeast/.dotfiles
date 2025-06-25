return {
	'nvim-telescope/telescope.nvim',
	event = 'VimEnter',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			'nvim-telescope/telescope-fzf-native.nvim',
			build = 'make',
			cond = function()
				return vim.fn.executable 'make' == 1
			end,
		},
		{ 'nvim-telescope/telescope-ui-select.nvim' },
		{ 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font, lazy = false},
	},
	config = function()
		require('telescope').setup{
			defaults = vim.tbl_deep_extend("force",
				require('telescope.themes').get_dropdown{},
				{
					mappings = {
						n = {
							['d'] = require('telescope.actions').delete_buffer,
						},
					},
				}
			),
			pickers = {},
			extensions = {
				['ui-select'] = {
					require('telescope.themes').get_dropdown(),
				},
			},
		}

		pcall(require('telescope').load_extension, 'fzf')
		pcall(require('telescope').load_extension, 'ui-select')

		local builtin = require 'telescope.builtin'
		vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[P] search [h]elp' })
		vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[P] search keymaps' })
		vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = '[P] find in directory' })
		vim.keymap.set('n', '<leader>sf', builtin.git_files, { desc = '[P] find in directory' })
		vim.keymap.set('n', '<leader>st', builtin.builtin, { desc = '[P] search select [t]elescope' })
		vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[P] search current [w]ord' })
		vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[P] search by [g]rep' })
		vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[P] search [d]iagnostics' })
		vim.keymap.set('n', '<leader>sb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<CR>', { desc = '[P] search existing [b]uffers' })
		-- vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
		-- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })

		-- search in nvim config dir
		vim.keymap.set('n', '<leader>sn', function()
			builtin.find_files { cwd = vim.fn.stdpath 'config' }
		end, { desc = '[P] search in [n]vim directory' })

		-- search in obsidian dir
		vim.keymap.set('n', '<leader>so', function()
			builtin.find_files { cwd = vim.g.obsidian_path }
		end, { desc = '[P] search in [o]bsidian directory' })

	end,
}
