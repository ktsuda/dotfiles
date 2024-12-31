return {
  'williamboman/mason.nvim',
  enabled = true,
  event = 'VeryLazy',
  build = ':MasonUpdate',
  cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
  opts = {},
}
