vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local map = vim.keymap.set

map('n', '<Esc>', vim.cmd.nohlsearch, { desc = '[P] remove search highlight' })
map('i', 'kj', '<Esc>')
map('v', '<leader>y', '"+y')

--  use ctrl+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = '[P] move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = '[P] move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = '[P] move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = '[P] move focus to the upper window' })

map('n', '<C-d>', '<C-d>zz', { desc = '[P] move up by half page' })
map('n', '<C-u>', '<C-u>zz', { desc = '[P] move down by half page' })
map('n', 'Y', 'yy', { desc = '[P] copy line' })

local demap = vim.keymap.del
