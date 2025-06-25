return	{
	{
	'eandrju/cellular-automaton.nvim',
	event = 'VeryLazy',
	config = function()
		vim.keymap.set('n', "<leader>'r", '<cmd>CellularAutomaton make_it_rain<cr>', { desc = '[fun] pixel rain' })
		vim.keymap.set('n', "<leader>'g", '<cmd>CellularAutomaton game_of_life<cr>', { desc = '[fun] game of life' })
		vim.keymap.set('n', "<leader>'s", '<cmd>CellularAutomaton scramble<cr>', { desc = '[fun] censor editor' })
	end
	},
	{
		'tamton-aquib/duck.nvim',
		event = 'VeryLazy',
		config = function()
			vim.keymap.set('n', "<leader>'d", function()
				for _ = 1, 10 do
					-- candidates: 🦆 ඞ 🦀 🐈 🐎 🦖 🐤
					require("duck").hatch('🐤', 10)
				end
			end, { desc = '[fun] spawn 10 pets' })
			vim.keymap.set('n', "<leader>'k", function()
				for _ = 1, 10 do
				require("duck").cook()
				end
			end, { desc = '[fun] kill 10 pets' })
			vim.keymap.set('n', "<leader>'K", function() require("duck").cook_all() end, { desc = '[fun] kill all pets💔' })
		end
	},
	{
		'ThePrimeagen/vim-be-good',
		event = 'VeryLazy',
	},
}
