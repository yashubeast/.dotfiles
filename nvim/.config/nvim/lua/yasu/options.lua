-- vim.g.md_heading_bg = 'transparent'
vim.g.obsidian_path = '/mnt/c/winapps/obsidian/obsidian-vault'
vim.g.greetings = {
	" did your todo's ? ",
	' hydrate ',
	' banana ',
	' music ',
}

vim.g.have_nerd_font = true
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)
vim.o.breakindent = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.wrap = false
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = false
vim.o.showmode = false
vim.o.ignorecase = true
vim.o.smartcase = true
-- vim.o.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.cmdheight = 0
-- vim.o.list = true
-- vim.o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.confirm = true

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
