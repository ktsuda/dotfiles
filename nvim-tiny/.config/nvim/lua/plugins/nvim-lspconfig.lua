return {
  'neovim/nvim-lspconfig',
  enabled = true,
  event = 'VeryLazy',
  keys = {
    { 'K', vim.lsp.buf.hover, mode = 'n', desc = 'LSP: Show hover' },
    { 'gd', vim.lsp.buf.definition, mode = 'n', desc = 'LSP: Go to definition' },
  },
  config = function()
    vim.lsp.enable('clangd')
    vim.lsp.enable('pyright')
    vim.lsp.enable('lua_ls')
    vim.lsp.enable('gopls')
    vim.lsp.enable('tailwindcss')
    vim.lsp.enable('ts_ls')
  end,
}
