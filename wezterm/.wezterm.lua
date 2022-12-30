local wezterm = require('wezterm')
return {
  font_size = 14.0,
  color_scheme = 'Solarized Dark - Patched',
  keys = {
    {
      key = 'Enter',
      mods = 'CMD',
      action = wezterm.action.ToggleFullScreen,
    },
  },
}
