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

		-- de-render markdown when the cursor is on the line
		-- anti_conceal = {
		-- 	enabled = true,
		-- 	ignore = {
		-- 		code_background = true,
		-- 		sign = true,
		-- 	},
		-- 	above = 0,
		-- 	below = 0,
		-- },

		quote = {
			-- icon = '▋',
			repeat_linebreak = true,
		},

		-- callout = {
		-- 	note      = { raw = '[!NOTE]',      rendered = '󰋽 Note',      highlight = 'RenderMarkdownInfo',    category = 'github'   },
		-- 	tip       = { raw = '[!TIP]',       rendered = '󰌶 Tip',       highlight = 'RenderMarkdownSuccess', category = 'github'   },
		-- 	important = { raw = '[!IMPORTANT]', rendered = '󰅾 Important', highlight = 'RenderMarkdownHint',    category = 'github'   },
		-- 	warning   = { raw = '[!WARNING]',   rendered = '󰀪 Warning',   highlight = 'RenderMarkdownWarn',    category = 'github'   },
		-- 	caution   = { raw = '[!CAUTION]',   rendered = '󰳦 Caution',   highlight = 'RenderMarkdownError',   category = 'github'   },
		-- 	abstract  = { raw = '[!ABSTRACT]',  rendered = '󰨸 Abstract',  highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
		-- 	summary   = { raw = '[!SUMMARY]',   rendered = '󰨸 Summary',   highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
		-- 	tldr      = { raw = '[!TLDR]',      rendered = '󰨸 Tldr',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
		-- 	info      = { raw = '[!INFO]',      rendered = '󰋽 Info',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
		-- 	todo      = { raw = '[!TODO]',      rendered = '󰗡 Todo',      highlight = 'RenderMarkdownInfo',    category = 'obsidian' },
		-- 	hint      = { raw = '[!HINT]',      rendered = '󰌶 Hint',      highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
		-- 	success   = { raw = '[!SUCCESS]',   rendered = '󰄬 Success',   highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
		-- 	check     = { raw = '[!CHECK]',     rendered = '󰄬 Check',     highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
		-- 	done      = { raw = '[!DONE]',      rendered = '󰄬 Done',      highlight = 'RenderMarkdownSuccess', category = 'obsidian' },
		-- 	question  = { raw = '[!QUESTION]',  rendered = '󰘥 Question',  highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
		-- 	help      = { raw = '[!HELP]',      rendered = '󰘥 Help',      highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
		-- 	faq       = { raw = '[!FAQ]',       rendered = '󰘥 Faq',       highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
		-- 	attention = { raw = '[!ATTENTION]', rendered = '󰀪 Attention', highlight = 'RenderMarkdownWarn',    category = 'obsidian' },
		-- 	failure   = { raw = '[!FAILURE]',   rendered = '󰅖 Failure',   highlight = 'RenderMarkdownError',   category = 'obsidian' },
		-- 	fail      = { raw = '[!FAIL]',      rendered = '󰅖 Fail',      highlight = 'RenderMarkdownError',   category = 'obsidian' },
		-- 	missing   = { raw = '[!MISSING]',   rendered = '󰅖 Missing',   highlight = 'RenderMarkdownError',   category = 'obsidian' },
		-- 	danger    = { raw = '[!DANGER]',    rendered = '󱐌 Danger',    highlight = 'RenderMarkdownError',   category = 'obsidian' },
		-- 	error     = { raw = '[!ERROR]',     rendered = '󱐌 Error',     highlight = 'RenderMarkdownError',   category = 'obsidian' },
		-- 	bug       = { raw = '[!BUG]',       rendered = '󰨰 Bug',       highlight = 'RenderMarkdownError',   category = 'obsidian' },
		-- 	example   = { raw = '[!EXAMPLE]',   rendered = '󰉹 Example',   highlight = 'RenderMarkdownHint' ,   category = 'obsidian' },
		-- 	quote     = { raw = '[!QUOTE]',     rendered = '󱆨 Quote',     highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
		-- 	cite      = { raw = '[!CITE]',      rendered = '󱆨 Cite',      highlight = 'RenderMarkdownQuote',   category = 'obsidian' },
		-- },

    checkbox = {
      enabled = true,
			-- right_pad = 1,

      unchecked = {
        icon = "󰄱",
      },

      checked = {
        icon = "󰱒",
      },

			-- custom = {
			-- 	todo = { raw = '[-]', rendered = '󰥔', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
			-- 	scope_highlight = @markup.strikethrough
			-- },
    },

		code = {
			sign = false,
			style = 'full',
			width = 'block',
			-- left_pad = 2,
			-- right_pad = 4,
		},

		dash = {
			enabled = true,
		},

    heading = {
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

		-- broken doesn't work properly
		-- indent = {
		-- 	enabled = true,
		-- skip_heading = true,
		-- },

    bullet = {
      -- Turn on / off list bullet rendering
      enabled = true,
			render_modes = true,
			-- icons = { '●' },
			icons = { '' },
    },

    -- html = {
    --   -- Turn on / off all HTML rendering
    --   enabled = true,
    --   comment = {
    --     -- Turn on / off HTML comment concealing
    --     conceal = false,
    --   },
    -- },

    -- link = {
    --   image = vim.g.neovim_mode == "skitty" and "" or "󰥶 ",
    --   custom = {
    --     youtu = { pattern = "youtu%.be", icon = "󰗃 " },
    --   },
    -- },

		sign = {
			enabled = false,
		},
  },
}
