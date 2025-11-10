return {
  'neovim/nvim-lspconfig',
  enabled = true,
  event = 'VeryLazy',
  keys = {
    { 'K', vim.lsp.buf.hover, mode = 'n', desc = 'LSP: Show hover' },
    { 'gd', vim.lsp.buf.definition, mode = 'n', desc = 'LSP: Go to definition' },
  },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
  },
  config = function()
    local lsp = require('utils.lsp-servers')
    vim.lsp.config('*', {
      root_markers = { '.git' },
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })
    for _, server_name in ipairs(lsp.names or {}) do
      vim.lsp.enable(server_name)
    end
  end,
}
