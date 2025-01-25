local M = {}

M.on_attach = function(client, bufnr)
  vim.lsp.set_log_level('off')
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'LSP: Show hover' })
  vim.keymap.set(
    'n',
    '<leader>wa',
    vim.lsp.buf.add_workspace_folder,
    { buffer = bufnr, desc = 'LSP: Add a workspace folder' }
  )
  vim.keymap.set(
    'n',
    '<leader>wr',
    vim.lsp.buf.remove_workspace_folder,
    { buffer = bufnr, desc = 'LSP: Remove a workspace folder' }
  )
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = 'LSP: List workspace folders' })
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP: Go to declaration' })
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: Go to definition' })
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP: Go to implementation' })
  vim.keymap.set('n', '<leader>sh', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'LSP: Show signature help' })
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'LSP: Go to type definition' })
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'LSP: Show references' })
  vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: Code action' })
end

M.on_init = function(client, _)
  if client.supports_method('textDocument/semanticTokens') then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.server_configs = {
  clangd = {
    cmd = {
      -- see clangd --help-hidden
      'clangd',
      '--background-index',
      -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
      -- to add more checks, create .clang-tidy file in the root directory
      -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
      '--clang-tidy',
      '--completion-style=bundled',
      '--cross-file-rename',
      '--header-insertion=iwyu',
    },
    init_options = {
      clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
      usePlaceholders = true,
      completeUnimported = true,
      semanticHighlighting = true,
    },
  },
  pyright = {
    settings = {
      python = {
        analysis = { typeCheckingMode = 'off' },
      },
    },
    single_file_support = false,
    cmd = { 'bash', '-c', 'source ./.venv/bin/activate && ./.venv/bin/pyright-langserver --stdio' },
  },
  lua_ls = {
    settings = {
      Lua = {
        workspace = {
          checkThirdParty = false,
          library = {
            vim.fn.expand('$VIMRUNTIME/lua'),
            vim.fn.expand('$VIMRUNTIME/lua/vim/lsp'),
            vim.fn.stdpath('data') .. '/lazy/lazy.nvim/lua/lazy',
            '${3rd}/luv/library',
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
        telemetry = { enable = false },
        diagnostics = {
          globals = { 'vim' },
          disable = { 'missing-fields' },
        },
      },
    },
  },
  gopls = {},
  tailwindcss = {},
  ts_ls = {
    filetypes = {
      'typescript',
      'typescriptreact',
      'typescript.tsx',
      'javascript',
      'javascriptreact',
      'javascript.jsx',
    },
    cmd = { 'typescript-language-server', '--stdio' },
  },
  denols = {},
}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      'documentation',
      'detail',
      'additionalTextEdits',
    },
  },
}
M.capabilities = capabilities

return M
