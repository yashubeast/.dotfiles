return {
	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup {}
		end,
	},
	{
		'williamboman/mason-lspconfig.nvim',
		config = function()
			require('mason-lspconfig').setup {
				ensure_installed = {
					'lua_ls',
					-- markdown
					'marksman',
					-- json
					'jsonls',
					-- javascript, typescript
					'ts_ls',
					'eslint-lsp',
					-- 'prisma-language-server',
					-- docker, compose
					'dockerls',
					'yamlls',
					-- python
					'pyright',
					-- web
					'html',
					'cssls',
					-- 'tailwindcss',
					'emmet_ls',
				}
			}
		end,
	},
	{
		'neovim/nvim-lspconfig',
		dependencies = {
			'saghen/blink.cmp',
		},
		opts = {
			servers = {
				lua_ls = {},
				marksman = {},
				ts_ls = {},
			}
		},
		config = function(_, opts)
			local lspconfig = require('lspconfig')
			for server, config in pairs(opts.servers) do
				config.capabilities = require('blink.cmp').get_lsp_capabilities()
				lspconfig[server].setup(config)


			vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = '[P] view info' })
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[P] jump to definition' })
			vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, { desc = '[P] view code action' })

			vim.diagnostic.config {
				severity_sort = true,
				float = { border = 'rounded', source = 'if_many' },
				underline = {
						severity = { min = vim.diagnostic.severity.WARN }
				},
				signs = false,
				-- signs = vim.g.have_nerd_font and {
				-- 	text = {
				-- 		[vim.diagnostic.severity.ERROR] = '󰅚 ',
				-- 		[vim.diagnostic.severity.WARN] = '󰀪 ',
				-- 		[vim.diagnostic.severity.INFO] = '󰋽 ',
				-- 		[vim.diagnostic.severity.HINT] = '󰌶 ',
				-- 	},
				-- } or {},
				virtual_text = {
					source = 'if_many',
					spacing = 2,
					severity = { min = vim.diagnostic.severity.WARN },
					format = function(diagnostic)
							return diagnostic.message
					end,
					-- format = function(diagnostic)
					-- 	local diagnostic_message = {
					-- 		[vim.diagnostic.severity.ERROR] = diagnostic.message,
					-- 		[vim.diagnostic.severity.WARN] = diagnostic.message,
					-- 		[vim.diagnostic.severity.INFO] = diagnostic.message,
					-- 		[vim.diagnostic.severity.HINT] = diagnostic.message,
					-- 	}
					-- 	return diagnostic_message[diagnostic.severity]
					-- end
				}
			}
			end
		end
	}
}
