local wezterm = require('wezterm')
return {
    font_size = 13.0,
    color_scheme = 'Solarized Dark - Patched',
    leader = { key = 't', mods = 'CTRL', timeout_milliseconds = 1000 },
    keys = {
        { key = '|',     mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
        { key = '%',     mods = 'LEADER|SHIFT', action = wezterm.action.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
        { key = '"',     mods = 'LEADER|SHIFT', action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
        { key = '-',     mods = 'LEADER',       action = wezterm.action.SplitVertical({ domain = 'CurrentPaneDomain' }) },
        { key = '[',     mods = 'LEADER',       action = wezterm.action.ActivateCopyMode },
        { key = ']',     mods = 'LEADER',       action = wezterm.action.PasteFrom('Clipboard') },
        { key = 'l',     mods = 'LEADER',       action = wezterm.action.ActivatePaneDirection('Right') },
        { key = 'h',     mods = 'LEADER',       action = wezterm.action.ActivatePaneDirection('Left') },
        { key = 'j',     mods = 'LEADER',       action = wezterm.action.ActivatePaneDirection('Down') },
        { key = 'k',     mods = 'LEADER',       action = wezterm.action.ActivatePaneDirection('Up') },
        { key = 'l',     mods = 'LEADER|CTRL',  action = wezterm.action.ActivatePaneDirection('Right') },
        { key = 'h',     mods = 'LEADER|CTRL',  action = wezterm.action.ActivatePaneDirection('Left') },
        { key = 'j',     mods = 'LEADER|CTRL',  action = wezterm.action.ActivatePaneDirection('Down') },
        { key = 'k',     mods = 'LEADER|CTRL',  action = wezterm.action.ActivatePaneDirection('Up') },
        { key = 'l',     mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Right', 1 }) },
        { key = 'h',     mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Left', 1 }) },
        { key = 'j',     mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Down', 1 }) },
        { key = 'k',     mods = 'LEADER|SHIFT', action = wezterm.action.AdjustPaneSize({ 'Up', 1 }) },
        { key = 'c',     mods = 'LEADER',       action = wezterm.action.SpawnTab('CurrentPaneDomain') },
        { key = 'c',     mods = 'LEADER|CTRL',  action = wezterm.action.SpawnTab('CurrentPaneDomain') },
        { key = 'n',     mods = 'LEADER',       action = wezterm.action.ActivateTabRelative(1) },
        { key = 'n',     mods = 'LEADER|CTRL',  action = wezterm.action.ActivateTabRelative(1) },
        { key = 'p',     mods = 'LEADER',       action = wezterm.action.ActivateTabRelative( -1) },
        { key = 'p',     mods = 'LEADER|CTRL',  action = wezterm.action.ActivateTabRelative( -1) },
        { key = 'q',     mods = 'LEADER',       action = wezterm.action.TogglePaneZoomState },
        { key = 'q',     mods = 'LEADER|CTRL',  action = wezterm.action.TogglePaneZoomState },
        { key = 'Enter', mods = 'CMD',          action = wezterm.action.ToggleFullScreen },
    },
}
