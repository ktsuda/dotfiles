local M = {}

local wezterm = require('wezterm')

function M.merge_tables(t1, t2)
  local merged = {}
  for _, v in ipairs(t1) do
    table.insert(merged, v)
  end
  for _, v in ipairs(t2) do
    table.insert(merged, v)
  end
  return merged
end

M.color_scheme = 'Catppuccin Mocha' -- or Macchiato, Frappe, Latte

local ctp_fg = '#494d64'
local ctp_bg = '#1e1e2e'
local ctp_crust = '#181926'
local ctp_mauve = '#c6a0f6'

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
    { Text = text },
    { Foreground = { Color = edge_fg } },
    { Background = { Color = edge_bg } },
    { Text = ' ' },
  }
end

return M
