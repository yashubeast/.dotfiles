return {
  "kevinhwang91/nvim-ufo",
  dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"kevinhwang91/promise-async",
	},
  -- event = "BufReadPost",   -- load on first real buffer
  opts = {
    provider_selector = function() return { "treesitter", "indent" } end,

    --- Custom fold text ----------------------------------------------------
    fold_virt_text_handler = function(virt_text, lnum, end_lnum, width, truncate)
      ----------------------------------------------------------------------
      -- 1. Detect heading level from the first line inside the fold
      ----------------------------------------------------------------------
      local line  = vim.api.nvim_buf_get_lines(0, lnum - 1, lnum, false)[1]
      local hashes, title = line:match("^(#+)%s+(.*)")
      if not hashes then
        return virt_text   -- not a heading fold → keep default
      end
      local level = #hashes                      -- 1-6
      local icon  = ({ "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " })[level]
      local hl    = ("Headline%dBg"):format(level) -- your highlight groups

      ----------------------------------------------------------------------
      -- 2. Compose left part  (icon + title)
      ----------------------------------------------------------------------
      local left = icon .. title
      if #left > width - 10 then              -- truncate if too long
        left = truncate(left, width - 10, "") -- keep icon, cut title
      end

      ----------------------------------------------------------------------
      -- 3. Compose right part  (⏷ 7 lines)
      ----------------------------------------------------------------------
      local lines = (" %d lines "):format(end_lnum - lnum + 1)
      local right = "⏷" .. lines
      -- local pad   = width - vim.fn.strdisplaywidth(left) - vim.fn.strdisplaywidth(right)
      -- if pad > 0 then left = left .. string.rep(" ", pad) end

      ----------------------------------------------------------------------
      -- 4. Return a table { {text, hl}, {text, hl}, … }
      ----------------------------------------------------------------------
      return {
        { " " .. left .. " ", hl },
        { " ⏷ " .. (end_lnum - lnum + 1) .. " lines", "Comment" },
				-- { right, "Comment" },
      }
    end,
  },
}
