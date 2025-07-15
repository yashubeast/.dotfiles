-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/gitsigns.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/gitsigns.lua

-- Plugin that shows git changes in the left sign column
-- I also use this plugin to run ghd and see the diff in the current buffer, I
-- like having wrap on the vim splits, so that's why I added folke's config here
-- https://www.lazyvim.org/plugins/editor#gitsignsnvim

return {
  "lewis6991/gitsigns.nvim",
  event = "VeryLazy",
  opts = {
		signcolumn = false,
		numhl = true,
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
  },
}
