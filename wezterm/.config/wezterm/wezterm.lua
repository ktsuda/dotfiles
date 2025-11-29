-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Changing the font size and color scheme.
config.font = wezterm.font('UbuntuMono Nerd Font')
config.font_size = 13.0
config.color_scheme = 'Catppuccin Mocha'

-- Set the appearance of the tab bar
config.hide_tab_bar_if_only_one_tab = true

-- Finally, return the configuration to wezterm:
return config
