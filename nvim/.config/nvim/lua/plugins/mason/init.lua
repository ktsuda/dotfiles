vim.pack.add({
  { src = 'https://github.com/williamboman/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  { src = 'https://github.com/rshkarin/mason-nvim-lint' },
  { src = 'https://github.com/zapling/mason-conform.nvim', version = 'main' },
})

require('mason').setup()

local lsp = require('utils.lsp')
require('mason-lspconfig').setup({
  ensure_installed = lsp.servers,
})

require('mason-nvim-lint').setup({
  automatic_installation = true,
})

require('mason-conform').setup({
  automatic_installation = true,
})
