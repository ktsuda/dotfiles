local M = {}

local wezterm = require('wezterm')

-- colors
local c = require('catppuccin_mocha')
local status_bg = c.base
-- local status_fg = c.text
local part_fg = c.subtext_0
local part_bg = c.surface_0
local tab_bg = c.surface_1
local tab_fg = c.subtext_1
local tab_bg_active = c.mauve
local tab_fg_active = c.crust

M.color_scheme = c.color_scheme

M.colors = {
  tab_bar = {
    background = status_bg,
    inactive_tab_edge = 'none',
  },
}

-- utils
function M.merge_tables(...)
  local merged = {}

  for i = 1, select('#', ...) do
    local obj = (select(i, ...))

    for _, v in ipairs(obj) do
      table.insert(merged, v)
    end
  end

  return merged
end

-- status and tab formatting
function M.tab_title(tab_info)
  local title = tab_info.tab_title

  if title and #title > 0 then
    return title
  end

  return tab_info.active_pane.title
end

function M.status_part(text, fg, bg)
  return {
    { Foreground = { Color = fg } },
    { Background = { Color = bg } },
    { Text = text },
  }
end

function M.format_farleft_status(text)
  return M.merge_tables(
    M.status_part(' ' .. text .. ' ', part_fg, part_bg),
    M.status_part(wezterm.nerdfonts.pl_right_hard_divider, status_bg, part_bg)
  )
end

function M.format_farright_status(text)
  return M.merge_tables(
    M.status_part(wezterm.nerdfonts.pl_right_hard_divider, part_bg, status_bg),
    M.status_part(' ' .. text .. ' ', part_fg, part_bg)
  )
end

function M.format_status(text)
  return M.merge_tables(
    M.status_part(wezterm.nerdfonts.pl_right_hard_divider, part_bg, status_bg),
    M.status_part(' ' .. text .. ' ', part_fg, part_bg),
    M.status_part(wezterm.nerdfonts.pl_right_hard_divider, status_bg, part_bg)
  )
end

function M.format_tab(bool, text)
  local fg = tab_fg
  local bg = tab_bg

  if bool then
    fg = tab_fg_active
    bg = tab_bg_active
  end

  local edge_fg = bg
  local edge_bg = status_bg

  return M.merge_tables(
    M.status_part(wezterm.nerdfonts.pl_right_hard_divider, edge_fg, edge_bg),
    M.status_part(' ' .. text .. ' ', fg, bg),
    M.status_part(wezterm.nerdfonts.pl_right_hard_divider, edge_bg, edge_fg)
  )
end

return M
