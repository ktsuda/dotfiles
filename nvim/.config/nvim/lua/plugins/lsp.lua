local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then return end
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not cmp_nvim_lsp_status then return end

local on_attach = function(_, bufnr)
  vim.lsp.set_log_level('debug')
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', vim.lsp.buf.format, bufopts)
  local lsp_augroup = 'LspFormat' .. bufnr
  vim.api.nvim_create_augroup(lsp_augroup, { clear = true })
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = lsp_augroup,
    buffer = bufnr,
    callback = function(_)
      -- vim.lsp.buf.format({ timeout_ms = 3000 })
    end,
  })
end

local servers = {
  'clangd',
  'pyright',
  'tsserver',
  'sumneko_lua',
  'gopls',
  'marksman',
}

for _, lspserver in ipairs(servers) do
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local lsp_flags = { debounce_text_chages = 150 }
  local lspconfig_opts = { on_attach = on_attach, flags = lsp_flags }

  if lspserver == 'clangd' then
    capabilities.offsetEncoding = { 'utf-16' }
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    }, lspconfig_opts)
  elseif lspserver == 'pyright' then
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
      settings = {
        python = {
          analysis = {
            typeCheckingMode = 'off',
          },
        },
      },
    }, lspconfig_opts)
  elseif lspserver == 'sumneko_lua' then
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    }, lspconfig_opts)
  else
    lspconfig_opts = vim.tbl_deep_extend('force', {
      capabilities = cmp_nvim_lsp.default_capabilities(capabilities),
    }, lspconfig_opts)
  end

  lspconfig[lspserver].setup(lspconfig_opts)
end
