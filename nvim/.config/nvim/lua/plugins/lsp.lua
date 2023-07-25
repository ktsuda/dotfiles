return {
  'williamboman/mason-lspconfig.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
      cmd = 'Mason',
      opts = {},
    },
    { 'neovim/nvim-lspconfig' },
    {
      'hrsh7th/cmp-nvim-lsp',
      cond = function()
        return require('lazy.core.config').plugins['nvim-cmp'] ~= nil
      end,
    },
  },
  config = function()
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
      gopls = {},
      tailwindcss = {},
      tsserver = {
        filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx', 'javascript', 'javascriptreact' },
        cmd = { 'typescript-language-server', '--stdio' },
      },
    }
    local flags = { debounce_text_chages = 150 }
    local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

    local mason_lspc = require('mason-lspconfig')
    mason_lspc.setup({
      ensure_installed = vim.tbl_keys(servers),
    })
    mason_lspc.setup_handlers({
      function(server_name)
        require('lspconfig')[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          flags = flags,
          settings = servers[server_name],
        })
      end,
    })
  end,
}
