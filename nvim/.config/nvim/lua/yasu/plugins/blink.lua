return {
	{
		'saghen/blink.cmp',
		dependencies = 'rafamadriz/friendly-snippets',

		version = 'v1.*',
		opts = {
			keymap = {
				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },

				['<C-c>'] = { 'select_and_accept' },

				['<Up>'] = { 'select_prev', 'fallback' },
				['<Down>'] = { 'select_next', 'fallback' },
				['<C-p>'] = { 'select_prev', 'fallback_to_mappings' },
				['<C-n>'] = { 'select_next', 'fallback_to_mappings' },

				['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
				['<C-f>'] = { 'scroll_documentation_down', 'fallback' },

				['<Tab>'] = { 'snippet_forward', 'fallback' },
				['<S-Tab>'] = { 'snippet_backward', 'fallback' },

				['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = 'normal'
			},
			completion = { documentation = { auto_show = false } },
			signature = { enabled = true }
		},
	},
}
