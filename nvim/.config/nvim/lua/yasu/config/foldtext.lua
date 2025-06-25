local M = {}

local icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " }

function M.markdown()
  local line = vim.fn.getline(vim.v.foldstart)
  local hashes, text = line:match("^(#+)%s*(.+)$")
  if hashes then
    local level = #hashes
    local icon = icons[level] or ""
    return " " .. icon .. " " .. text
  end
  return line
end

return M

