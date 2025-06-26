-- https://github.com/MeanderingProgrammer/render-markdown.nvim

local colors = require("yasu.config.colors")
return {
  "MeanderingProgrammer/render-markdown.nvim",
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
		'nvim-tree/nvim-web-devicons'
	},
  enabled = true,
  -- Moved highlight creation out of opts as suggested by plugin maintainer
  -- There was no issue, but it was creating unnecessary noise when ran
  -- :checkhealth render-markdown
  -- https://github.com/MeanderingProgrammer/render-markdown.nvim/issues/138#issuecomment-2295422741
  init = function()
		-- vim.opt.termguicolors = true
		vim.api.nvim_set_hl(0, "@markup.italic.markdown_inline", { italic = true })
		vim.api.nvim_set_hl(0, "@markup.strong.markdown_inline", { bold = true })

    local colorInline_bg = colors["linkarzu_color02"]
    local color_fg = colors["linkarzu_color26"]
    -- local color_sign = "#ebfafa"
    if vim.g.md_heading_bg == "transparent" then
      -- Define color variables
      local color1_bg = colors["linkarzu_color04"]
      local color2_bg = colors["linkarzu_color02"]
      local color3_bg = colors["linkarzu_color03"]
      local color4_bg = colors["linkarzu_color01"]
      local color5_bg = colors["linkarzu_color05"]
      local color6_bg = colors["linkarzu_color08"]
      local color_fg1 = colors["linkarzu_color18"]
      local color_fg2 = colors["linkarzu_color19"]
      local color_fg3 = colors["linkarzu_color20"]
      local color_fg4 = colors["linkarzu_color21"]
      local color_fg5 = colors["linkarzu_color22"]
      local color_fg6 = colors["linkarzu_color23"]

      -- Heading colors (when not hovered over), extends through the entire line
      vim.cmd(string.format([[highlight Headline1Bg guibg=%s guifg=%s ]], color_fg1, color1_bg))
      vim.cmd(string.format([[highlight Headline2Bg guibg=%s guifg=%s ]], color_fg2, color2_bg))
      vim.cmd(string.format([[highlight Headline3Bg guibg=%s guifg=%s ]], color_fg3, color3_bg))
      vim.cmd(string.format([[highlight Headline4Bg guibg=%s guifg=%s ]], color_fg4, color4_bg))
      vim.cmd(string.format([[highlight Headline5Bg guibg=%s guifg=%s ]], color_fg5, color5_bg))
      vim.cmd(string.format([[highlight Headline6Bg guibg=%s guifg=%s ]], color_fg6, color6_bg))
      -- Define inline code highlight for markdown
      vim.cmd(string.format([[highlight RenderMarkdownCodeInline guifg=%s guibg=%s]], colorInline_bg, color_fg))
      -- vim.cmd(string.format([[highlight RenderMarkdownCodeInline guifg=%s]], colorInline_bg))

      -- Highlight for the heading and sign icons (symbol on the left)
      -- I have the sign disabled for now, so this makes no effect
      -- vim.cmd(string.format([[highlight Headline1Fg cterm=bold gui=bold guifg=%s]], color1_bg))
      -- vim.cmd(string.format([[highlight Headline2Fg cterm=bold gui=bold guifg=%s]], color2_bg))
      -- vim.cmd(string.format([[highlight Headline3Fg cterm=bold gui=bold guifg=%s]], color3_bg))
      -- vim.cmd(string.format([[highlight Headline4Fg cterm=bold gui=bold guifg=%s]], color4_bg))
      -- vim.cmd(string.format([[highlight Headline5Fg cterm=bold gui=bold guifg=%s]], color5_bg))
      -- vim.cmd(string.format([[highlight Headline6Fg cterm=bold gui=bold guifg=%s]], color6_bg))
    else
      -- local color1_bg = colors["linkarzu_color18"]
      -- local color2_bg = colors["linkarzu_color19"]
      -- local color3_bg = colors["linkarzu_color20"]
      -- local color4_bg = colors["linkarzu_color21"]
      -- local color5_bg = colors["linkarzu_color22"]
      -- local color6_bg = colors["linkarzu_color23"]
      local color1_bg = colors["linkarzu_color04"]
      local color2_bg = colors["linkarzu_color02"]
      local color3_bg = colors["linkarzu_color03"]
      local color4_bg = colors["linkarzu_color01"]
      local color5_bg = colors["linkarzu_color05"]
      local color6_bg = colors["linkarzu_color08"]
      vim.cmd(string.format([[highlight Headline1Bg guifg=%s guibg=%s]], color_fg, color1_bg))
      vim.cmd(string.format([[highlight Headline2Bg guifg=%s guibg=%s]], color_fg, color2_bg))
      vim.cmd(string.format([[highlight Headline3Bg guifg=%s guibg=%s]], color_fg, color3_bg))
      vim.cmd(string.format([[highlight Headline4Bg guifg=%s guibg=%s]], color_fg, color4_bg))
      vim.cmd(string.format([[highlight Headline5Bg guifg=%s guibg=%s]], color_fg, color5_bg))
      vim.cmd(string.format([[highlight Headline6Bg guifg=%s guibg=%s]], color_fg, color6_bg))
    end
  end,
  opts = {

		render_modes = true,

		quote = {
			enabled = true,
			-- icon = '▋',
			repeat_linebreak = true,
		},

    checkbox = {
      enabled = true,

      unchecked = {
        icon = "󰄱",
      },
      checked = {
        icon = "󰱒",
      },

			-- TODO: CHANGE COLOR FOR CUSTOM CHECKLISTS
			custom = {
				todo = {
					raw = '[~]',
					rendered = '󰥔',
					highlight = 'RenderMarkdownTodo',
					scope_highlight = nil
				},
				alert = {
					raw = '[!]',
					rendered = '',
					highlight = 'RenderMarkdownTodo',
					scope_highlight = nil},
				},
    },

		code = {
			enabled = true,
			sign = false,
			-- style = 'full',
			width = 'block',
			-- left_pad = 1,
			right_pad = 1,
			border = 'thin',
		},

		dash = {
			enabled = true,
		},

    heading = {
			enabled = true,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
			width = 'block',
			position = 'inline',
			left_pad = 1,
			right_pad = 1,
      backgrounds = {
        "Headline1Bg",
        "Headline2Bg",
        "Headline3Bg",
        "Headline4Bg",
        "Headline5Bg",
        "Headline6Bg",
      },
      foregrounds = {
        "Headline1Fg",
        "Headline2Fg",
        "Headline3Fg",
        "Headline4Fg",
        "Headline5Fg",
        "Headline6Fg",
      },
    },

    bullet = {
      enabled = true,
			icons = {''},
    },

    -- html = {
    --   enabled = true,
    --   -- comment = {
    --   --   -- Turn on / off HTML comment concealing
    --   --   conceal = false,
    --   -- },
    -- },

		-- link = {
		-- 	-- wiki = {
		-- 	-- 	icon = '󱗖 ',
		-- 	-- },
		-- },

		sign = {
			enabled = false,
		},
  },
}
