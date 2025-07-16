return {
	'nguyenvukhang/nvim-toggler',
	config = function()
		require('nvim-toggler').setup({
			-- your own inverses
			inverses = {
				['vim'] = 'emacs'
			},
			-- removes the default <leader>i keymap
			-- remove_default_keybinds = false, emacs
			-- removes the default set of inverses
			-- remove_default_inverses = true,
			-- auto-selects the longest match when there are multiple matches
			-- autoselect_longest_match = false
		})
	end
}
