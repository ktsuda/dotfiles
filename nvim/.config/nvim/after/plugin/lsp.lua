local lspc_status, lspc = pcall(require, 'lspconfig')
if not lspc_status then
  return
end

local cmp_lsp_status, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_lsp_status then
  return
end

local mason_status, mason = pcall(require, 'mason')
if not mason_status then
  return
end

local mason_lspc_status, mason_lspc = pcall(require, 'mason-lspconfig')
if not mason_lspc_status then
  return
end

mason.setup()

local on_attach = function(client, bufnr)
  vim.lsp.set_log_level('debug')

  client.server_capabilities.document_formatting = false

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  map('n', 'gD', vim.lsp.buf.declaration)
  map('n', 'gd', vim.lsp.buf.definition)
  map('n', 'K', vim.lsp.buf.hover)
  map('n', 'gi', vim.lsp.buf.implementation)
  map('n', 'gr', vim.lsp.buf.references)
end

local servers = {
  clangd = {},
  pyright = {
    python = {
      analysis = { typeCheckingMode = 'off' },
    },
  },
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { globals = { 'vim' } },
    },
  },
}

local flags = { debounce_text_chages = 150 }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_lsp.default_capabilities(capabilities)

mason_lspc.setup({ ensure_installed = vim.tbl_keys(servers) })

mason_lspc.setup_handlers({
  function(server_name)
    lspc[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      flags = flags,
      settings = servers[server_name],
    })
  end,
})
