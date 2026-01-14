local M = {}

local wezterm = require('wezterm')

local ctp_fg = '#494d64'
local ctp_bg = '#1e1e2e'
local ctp_crust = '#181926'
local ctp_mauve = '#c6a0f6'

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
    inactive_tab_edge = 'none',
  },
}

M.window_frame = {
  inactive_titlebar_bg = '#1e1e2e',
  active_titlebar_bg = '#1e1e2e',
}

function M.format_status(bool, text)
  local fg = ctp_fg
  local bg = ctp_bg

  if bool then
    fg = ctp_crust
    bg = ctp_mauve
  end

  local edge_fg = bg
  local edge_bg = 'none'

  return {
    { Foreground = { Color = edge_fg } },
    { Background = { Color = edge_bg } },
    { Text = ' ' },
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = ' ' .. text .. ' ' },
    { Foreground = { Color = edge_fg } },
    { Background = { Color = edge_bg } },
    { Text = ' ' },
  }
end

return M
