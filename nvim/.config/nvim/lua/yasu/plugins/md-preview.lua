-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/markdown-preview.lua
--
-- Link to github repo
-- https://github.com/iamcco/markdown-preview.nvim

return {
  "iamcco/markdown-preview.nvim",
	enabled = false,
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
		vim.g.mkdp_markdown_css = ''  -- disable custom CSS if interfering
		vim.g.mkdp_preview_options = {
			markdown = {
				breaks = true
			}
		}
  end,
  ft = { "markdown" },
}
