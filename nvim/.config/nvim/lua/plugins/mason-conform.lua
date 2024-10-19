return {
  'zapling/mason-conform.nvim',
  enabled = true,
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'stevearc/conform.nvim',
  },
  opts = {
    automatic_installation = true,
  },
}
