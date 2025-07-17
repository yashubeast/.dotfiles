local function ge(var)
    -- local f = io.popen("bash -c 'source ~/.config/yasu/theme/active.sh && echo -n $" .. var .. "'")
    local f = io.popen("bash -c 'source ~/.config/yasu/theme/active.sh && echo -n \"$" .. var .. "\"'")
    local val = f:read("*a")
    f:close()
    return val
end

opt = vim.o
glo = vim.g

-- vim.g.md_heading_bg = 'transparent'
glo.obsidian_path = ge("obsidian_path")
glo.greetings = {
	" did your todo's ? ",
	' hydrate ',
	' banana ',
	' music ',
}
glo.disabled = ge("disabled")

opt.guifont = ge("nvimFont") .. ":h" .. ge("fontSize")
glo.have_nerd_font = true
vim.schedule(function() opt.clipboard = 'unnamedplus' end)
opt.breakindent = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = false
opt.showmode = false
opt.ignorecase = true
opt.smartcase = true
-- opt.signcolumn = 'yes'
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.cmdheight = 0
-- opt.list = true
-- opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.confirm = true
opt.foldlevel = 99
opt.foldlevelstart = 99

-- highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
