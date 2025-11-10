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
    opts = function()
      local lsp = require('utils.lsp-servers')

      return { ensure_installed = lsp.names }
    end,
  },
  {
    'jay-babu/mason-nvim-dap.nvim',
    enabled = true,
    event = 'VeryLazy',
    dependencies = {
      'williamboman/mason.nvim',
      'mfussenegger/nvim-dap',
    },
    opts = function()
      local adapters = {}
      local cdap = require('utils.custom-dap')

      for adapter, _ in pairs(cdap.adapters or {}) do
        table.insert(adapters, adapter)
      end

      return {
        handlers = {},
        ensure_installed = adapters,
      }
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
