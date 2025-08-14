return {
  'neovim/nvim-lspconfig',
  enabled = true,
  event = 'VeryLazy',
  keys = {
    { 'K', vim.lsp.buf.hover, mode = 'n', desc = 'LSP: Show hover' },
    { 'gd', vim.lsp.buf.definition, mode = 'n', desc = 'LSP: Go to definition' },
  },
  config = function()
    local lsp = require('lsp.servers')
    for i, server_name in ipairs(lsp.names) do
      vim.lsp.enable(server_name)
    end
  end,
}
