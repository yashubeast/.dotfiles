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
		local km = vim.keymap.set
		km('n', '<leader>sh', builtin.help_tags, { desc = '[P] search [h]elp' })
		km('n', '<leader>sk', builtin.keymaps, { desc = '[P] search [k]eymaps' })
		km('n', '<leader>f', builtin.find_files, { desc = '[P] find in directory' })
		km('n', '<leader>sf', builtin.git_files, { desc = '[P] find in git directory' })
		km('n', '<leader>st', builtin.builtin, { desc = '[P] search select [t]elescope' })
		km('n', '<leader>sw', builtin.grep_string, { desc = '[P] search current [w]ord' })
		km('n', '<leader>sg', builtin.live_grep, { desc = '[P] search by live [g]rep' })
		km('n', '<leader>sd', builtin.diagnostics, { desc = '[P] search [d]iagnostics' })
		km('n', '<leader>sb', '<cmd>Telescope buffers sort_mru=true sort_lastused=true initial_mode=normal theme=ivy<CR>', { desc = '[P] search existing [b]uffers' })
		-- km('n', '<leader>sr', builtin.resume, { desc = '[s]earch [r]esume' })
		-- km('n', '<leader>s.', builtin.oldfiles, { desc = '[s]earch recent files ("." for repeat)' })

		-- search in nvim config dir
		km('n', '<leader>sn', function()
			builtin.find_files { cwd = vim.fn.stdpath 'config' }
		end, { desc = '[P] search in [n]vim directory' })

		-- search in obsidian dir
		km('n', '<leader>so', function()
			builtin.find_files { cwd = vim.g.obsidian_path }
		end, { desc = '[P] search in [o]bsidian directory' })

		-- search in config dir
		km('n', '<leader>sm', function()
			builtin.find_files { cwd = vim.fn.expand('~/') }
		end, { desc = '[P] search in config directory' })

	end,
}
