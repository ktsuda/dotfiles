-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Changing the font size and color scheme.
config.font = wezterm.font('UbuntuMono Nerd Font')
config.font_size = 13.0
config.color_scheme = 'Catppuccin Mocha'

-- Set the appearance
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.8

-- Finally, return the configuration to wezterm:
return config
