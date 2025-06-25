return {
  'ThePrimeagen/harpoon',
	enabled = true,
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local harpoon_ui = require("harpoon.ui")
		local harpoon_mark = require('harpoon.mark')

		vim.keymap.set("n", "<leader>hh", harpoon_ui.toggle_quick_menu, { desc = "[P] harpoon toggle quick menu" })
		vim.keymap.set("n", "<leader>ha", harpoon_mark.add_file, { desc = "[P] harpoon add file" })

		vim.keymap.set("n", "<leader>1", function() harpoon_ui.nav_file(1) end, { desc = "[P] harpoon go to file 1" })
		vim.keymap.set("n", "<leader>2", function() harpoon_ui.nav_file(2) end, { desc = "[P] harpoon go to file 2" })
		vim.keymap.set("n", "<leader>3", function() harpoon_ui.nav_file(3) end, { desc = "[P] harpoon go to file 3" })
		vim.keymap.set("n", "<leader>4", function() harpoon_ui.nav_file(4) end, { desc = "[P] harpoon go to file 4" })
		vim.keymap.set("n", "<leader>5", function() harpoon_ui.nav_file(5) end, { desc = "[P] harpoon go to file 5" })
		vim.keymap.set("n", "<leader>6", function() harpoon_ui.nav_file(6) end, { desc = "[P] harpoon go to file 6" })
		vim.keymap.set("n", "<leader>7", function() harpoon_ui.nav_file(7) end, { desc = "[P] harpoon go to file 7" })
		vim.keymap.set("n", "<leader>8", function() harpoon_ui.nav_file(8) end, { desc = "[P] harpoon go to file 8" })
		vim.keymap.set("n", "<leader>9", function() harpoon_ui.nav_file(9) end, { desc = "[P] harpoon go to file 9" })
		vim.keymap.set("n", "<leader>10", function() harpoon_ui.nav_file(10) end, { desc = "[P] harpoon go to file 10" })

		-- vim.keymap.set("n", "<leader>hn", harpoon_ui.nav_next, { desc = "harpoon next file" })
		-- vim.keymap.set("n", "<leader>hp", harpoon_ui.nav_prev, { desc = "harpoon previous file" })

		require("telescope").load_extension('harpoon')
		vim.keymap.set("n", "<leader>sp", '<cmd>Telescope harpoon marks<CR>', { desc = "[P] search har[p]oon marks" })

	end
}

