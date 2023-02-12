local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then return end
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then return end
local mason_status, mason = pcall(require, 'mason')
if not mason_status then return end
local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status then return end

mason.setup()

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
  clangd = {},
  pyright = {
    python = {
      analysis = {
        typeCheckingMode = 'off',
      },
    },
  },
  tsserver = {},
  marksman = {},
  lua_ls = {
    Lua = {
      workspace = {
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      diagnostics = {
        globals = { 'vim' },
      },
    },
  },
}

local flags = { debounce_text_chages = 150 }
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

mason_lspconfig.setup({
  ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      flags = flags,
      settings = servers[server_name],
    })
  end,
})
