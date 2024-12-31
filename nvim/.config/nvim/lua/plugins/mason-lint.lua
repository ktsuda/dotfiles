return {
  'rshkarin/mason-nvim-lint',
  enabled = true,
  event = 'VeryLazy',
  dependencies = {
    'williamboman/mason.nvim',
    'mfussenegger/nvim-lint',
  },
  opts = {
    automatic_installation = true,
  },
}
