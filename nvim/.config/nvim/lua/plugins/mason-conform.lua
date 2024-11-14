return {
  'ktsuda/mason-conform.nvim',
  enabled = true,
  event = 'VeryLazy',
  branch = 'mapping',
  dependencies = {
    'williamboman/mason.nvim',
    'stevearc/conform.nvim',
  },
  opts = {
    automatic_installation = true,
  },
}
