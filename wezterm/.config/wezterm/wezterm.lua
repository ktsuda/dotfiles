local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.use_ime = true

-- font
config.font = wezterm.font_with_fallback({ 'UbuntuMono Nerd Font', 'monospace' })
config.font_size = 13.0

-- theme
local theme = require('theme')

config.color_scheme = theme.color_scheme
config.colors = theme.colors
config.window_frame = theme.window_frame
config.window_background_opacity = 1

config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.hide_tab_bar_if_only_one_tab = true

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title = ' ' .. wezterm.truncate_right(tab.active_pane.title, max_width - 2) .. ' '
  return theme.format_status(tab.is_active, title)
end)

wezterm.on('update-right-status', function(window, pane)
  local date = wezterm.strftime('%Y-%m-%d %H:%M')
  local title = ' ' .. date .. ' '
  local hostname = ' ' .. wezterm.hostname() .. ' '
  local status_table = theme.merge_tables(theme.format_status(false, title), theme.format_status(false, hostname))
  window:set_right_status(wezterm.format(status_table))
end)

-- keys
local keybindings = require('keybindings')
config.keys = keybindings.keys
config.key_tables = keybindings.key_tables

config.disable_default_key_bindings = true
config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }

return config
