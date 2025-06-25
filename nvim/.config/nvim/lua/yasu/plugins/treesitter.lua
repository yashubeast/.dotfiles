return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	main = 'nvim-treesitter.configs',
	opts = {
		text_objects = {},
		ensure_installed = {
			'lua',
			'vim',
			'bash',
			-- markdown
			'markdown',
			'markdown_inline',
			-- file types
			'json',
			'yaml',
			'toml',
			'ini',
			-- python
			'python',
			-- javascript, typescript
			'javascript',
			'typescript',
			'tsx',
			-- web
			'html',
			'css',
			-- docker
			'dockerfile',
			-- misc
			'regex',
		},
		auto_install = true,
		highlight = { enable = true },
		indent = { enable = true },
	},
}
