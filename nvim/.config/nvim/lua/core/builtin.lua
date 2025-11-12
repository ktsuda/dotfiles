local disabled_builtins = {
  '2html_plugin',

  'gzip',
  'zip',
  'zipPlugin',
  'tar',
  'tarPlugin',

  'vimball',
  'vimballPlugin',

  'netrw',
  'netrwPlugin',
  'netrwSettings',
  'netrwFileHandlers',

  'getscript',
  'getscriptPlugin',

  'man',
  'matchit',
  'matchparen',
  'shada_plugin',
  'spellfile_plugin',
  'tutor_mode_plugin',
  'logipat',
  'rrhelper',
}

for _, plugin in pairs(disabled_builtins) do
  vim.g['loaded_' .. plugin] = 1
end
