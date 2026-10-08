vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
  callback = function()
    local root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("%s+$", "")
    if root ~= "" then
      vim.b.git_branch = "(" .. vim.fn.system("git branch --show-current 2>/dev/null"):gsub("%s+$", "") .. ")"
      vim.b.rel_path = vim.fn.expand("%:p"):sub(#root + 2)
    else
      vim.b.git_branch = nil
      vim.b.rel_path = vim.fn.expand("%:p:~")
    end
  end,
})

-- Define colors for each mode (catppuccin mocha theme)
local colors = {
  normal = "#89b4fa", -- Blue
  insert = "#a6e3a1", -- Green
  visual = "#cba6f7", -- Mauve
  replace = "#f38ba8", -- Red
  command = "#fab387", -- Peache
}

-- Create highlight groups dynamically
for mode, color in pairs(colors) do
  vim.api.nvim_set_hl(0, "Status" .. mode:gsub("^%l", string.upper), {
    fg = "#181825", -- Mantle
    bg = color,
    bold = true,
  })
end

local mode_map = {
  ["n"] = { " NORMAL ", "StatusNormal" },
  ["i"] = { " INSERT ", "StatusInsert" },
  ["v"] = { " VISUAL ", "StatusVisual" },
  ["V"] = { " V-LINE ", "StatusVisual" },
  ["\22"] = { " V-BLOCK ", "StatusVisual" },
  ["c"] = { " COMMAND ", "StatusCommand" },
  ["R"] = { " REPLACE ", "StatusReplace" },
}

local function statusline()
  -- Get current mode data, default to Normal if unknown
  local current_mode = vim.fn.mode()
  local mode_info = mode_map[current_mode] or { " NORMAL ", "StatusNormal" }

  local label = mode_info[1]
  local hl_group = mode_info[2]

  -- Construct the statusline string using item evaluation syntax
  -- %#GroupName# sets the highlight group, %* resets it
  return string.format(
    "%%#%s#%s%%* %%{get(b:, 'git_branch', '')} %%{get(b:, 'rel_path', '')} %%m %%= %%l:%%c ",
    hl_group,
    label
  )
end

_G.my_statusline = statusline

vim.o.statusline = "%!v:lua.my_statusline()"
