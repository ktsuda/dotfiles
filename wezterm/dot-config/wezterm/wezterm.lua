-- wezterm config file
local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.automatically_reload_config = true
config.use_ime = true

-- font
config.font = wezterm.font_with_fallback({ 'UbuntuMono Nerd Font', 'monospace' })
config.font_size = 16.0

-- theme
local theme = require('theme')

config.color_scheme = theme.color_scheme
config.colors = theme.colors
config.window_background_opacity = 1

config.use_fancy_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.hide_tab_bar_if_only_one_tab = false

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local title_txt = theme.tab_title(tab)
  local title = tab.tab_index .. ': ' .. wezterm.truncate_right(title_txt, max_width - 2)
  return theme.format_tab(tab.is_active, title)
end)

wezterm.on('update-status', function(window, pane)
  local date = wezterm.strftime('%Y-%m-%d %H:%M:%S')
  local hostname = '@' .. wezterm.hostname()
  local workspace = '[' .. wezterm.mux.get_active_workspace() .. ']'

  local left_status = theme.format_farleft_status(workspace)
  local right_status = theme.merge_tables(
		theme.format_status(date),
		theme.format_farright_status(hostname))

  window:set_left_status(wezterm.format(left_status))
  window:set_right_status(wezterm.format(right_status))
end)

-- keys
local keybindings = require('keybindings')
config.keys = keybindings.keys
config.key_tables = keybindings.key_tables

config.disable_default_key_bindings = true
config.leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 }

return config
