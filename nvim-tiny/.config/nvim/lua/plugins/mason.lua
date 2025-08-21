return {
  {
    'williamboman/mason.nvim',
    enabled = true,
    event = 'VeryLazy',
    build = ':MasonUpdate',
    cmd = { 'Mason', 'MasonInstall', 'MasonInstallAll', 'MasonUpdate' },
    opts = {},
  },
  {
    'williamboman/mason-lspconfig.nvim',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      local lsp = require('utils.lsp-servers')
      require('mason-lspconfig').setup({
        ensure_installed = lsp.names,
      })
    end,
  },
  {
    'zapling/mason-conform.nvim',
    enabled = true,
    event = 'VeryLazy',
    branch = 'main',
    dependencies = {
      'williamboman/mason.nvim',
      'stevearc/conform.nvim',
    },
    opts = {
      automatic_installation = true,
    },
  },
  {
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
  },
}
