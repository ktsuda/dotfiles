local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then return end
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then return end

local on_attach = function(client, bufnr)
  vim.lsp.set_log_level('debug')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  client.server_capabilities.document_formatting = false
end

local servers = {
  'clangd',
  'pyright',
  'tsserver',
  'sumneko_lua',
  'marksman',
}

local lsp_flags = { debounce_text_chages = 150 }
local lspconfig_opts = { on_attach = on_attach, flags = lsp_flags }
local capabilities = vim.lsp.protocol.make_client_capabilities()
local settings = {}

for _, lspserver in ipairs(servers) do
  if lspserver == 'clangd' then
    capabilities.offsetEncoding = { 'utf-16' }
  elseif lspserver == 'pyright' then
    settings.python = {
      analysis = {
        typeCheckingMode = 'off',
      },
    }
  elseif lspserver == 'sumneko_lua' then
    settings.Lua = {
      diagnostics = {
        globals = { 'vim' },
      },
    }
  end

  lspconfig_opts = vim.tbl_deep_extend('keep', lspconfig_opts, {
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
    settings = settings,
  })

  lspconfig[lspserver].setup(lspconfig_opts)
end
