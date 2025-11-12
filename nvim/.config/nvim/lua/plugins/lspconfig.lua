local group = vim.api.nvim_create_augroup('my.lsp', {})

local function load()
  vim.pack.add({
    { src = 'https://github.com/neovim/nvim-lspconfig' },
    { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
  })

  local lsp = require('utils.lsp')
  for _, server_name in ipairs(lsp.servers or {}) do
    vim.lsp.enable(server_name)
  end

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })

  vim.api.nvim_create_autocmd('LspAttach', {
    group = group,
    callback = function(args)
      local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

      if client:supports_method('textDocument/completion') then
        vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
      end
    end,
  })

  require('mason-lspconfig').setup({
    ensure_installed = lsp.servers,
  })
end

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
