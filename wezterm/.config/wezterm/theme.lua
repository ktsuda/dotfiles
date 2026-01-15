local M = {}

local wezterm = require('wezterm')
local colors = require('colors')

function M.tab_title(tab_info)
  local title = tab_info.tab_title

  if title and #title > 0 then
    return title
  end

  return tab_info.active_pane.title
end

function M.merge_tables(...)
  local merged = {}

  for i = 1, select('#', ...) do
    local arg = (select(i, ...))
    local obj = M.format_status(false, arg)

    for _, v in ipairs(obj) do
      table.insert(merged, v)
    end
  end

  return merged
end

M.color_scheme = 'Catppuccin Mocha' -- or Macchiato, Frappe, Latte

M.colors = {
  tab_bar = {
    background = colors.base,
    inactive_tab_edge = 'none',
  },
}

function M.format_status(bool, text)
  local fg = colors.text
  local bg = colors.surface_1

  if bool then
    fg = colors.crust
    bg = colors.mauve
  end

  local edge_fg = bg
  local edge_bg = colors.base

  return {
    { Foreground = { Color = edge_fg } },
    { Background = { Color = edge_bg } },
    { Text = wezterm.nerdfonts.pl_right_hard_divider },
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = ' ' .. text .. ' ' },
    { Foreground = { Color = edge_fg } },
    { Background = { Color = edge_bg } },
    { Text = wezterm.nerdfonts.ple_right_hard_divider_inverse },
  }
end

return M
