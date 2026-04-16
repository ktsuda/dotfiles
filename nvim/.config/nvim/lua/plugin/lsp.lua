vim.pack.add({
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
})

local lsp_servers = {
  'clangd',
  'lua_ls',
  'ts_ls',
  'tailwindcss',
}

for _, server_name in ipairs(lsp_servers or {}) do
  vim.lsp.enable(server_name)
end

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('my.lsp', {}),
  callback = function(args)
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
    end

    -- stylua: ignore start
    vim.keymap.set('n', 'K',  vim.lsp.buf.hover,          { desc = 'Show hover' })
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition,     { desc = 'Go to definition' })
    vim.keymap.set('n', 'gr', vim.lsp.buf.references,     { desc = 'Go to references' })
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
    -- stylua: ignore end
  end,
})

require('mason-lspconfig').setup({
  ensure_installed = lsp_servers,
})
