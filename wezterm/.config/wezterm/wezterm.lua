local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.use_ime = true

config.font = wezterm.font('UbuntuMono Nerd Font')
config.font_size = 13.0
config.window_background_opacity = 1
config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = 'Catppuccin Mocha' -- or Macchiato, Frappe, Latte
config.colors = { tab_bar = { inactive_tab_edge = 'none' } }

wezterm.on('format-tab-title', function(tab, _, _, _, _, max_width)
  local background = '#494d64'
  local foreground = '#1e1e2e'
  local edge_background = 'none'

  if tab.is_active then
    background = '#c6a0f6'
    foreground = '#181926'
  end

  local edge_foreground = background
  local title = ' ' .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. ' '

  return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = wezterm.nerdfonts.ple_lower_right_triangle },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = wezterm.nerdfonts.ple_upper_left_triangle },
  }
end)

config.keys = require('keybindings').keys
config.key_tables = require('keybindings').key_tables
config.disable_default_key_bindings = true
config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }

return config
