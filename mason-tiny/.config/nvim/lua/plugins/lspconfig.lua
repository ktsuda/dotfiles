return {
  'neovim/nvim-lspconfig',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'folke/lazydev.nvim',
  },
  config = function()
    local on_attach = function(client, bufnr)
      vim.lsp.set_log_level('off')
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
      local function nmap(l, r, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', l, r, { buffer = bufnr, desc = desc })
      end
      nmap('K', vim.lsp.buf.hover)
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder)
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder)
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end)
    end

    local server_configs = {
      clangd = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- diagnostics = { globals = { 'vim' } },
        },
      },
    }
    -- local flags = { debounce_text_chages = 150 }
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

    local mason_lspc = require('mason-lspconfig')
    mason_lspc.setup({
      ensure_installed = vim.tbl_keys(server_configs),
    })
    local lspconfig = require('lspconfig')
    -- for server, config in pairs(server_configs) do
    --   lspconfig[server].setup({
    --     capabilities = capabilities,
    --     on_attach = on_attach,
    --     -- flags = flags,
    --     settings = config,
    --     filetypes = (config or {}).filetypes,
    --   })
    -- end
    mason_lspc.setup_handlers({
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          -- flags = flags,
          settings = server_configs[server_name],
          filetypes = (server_configs[server_name] or {}).filetypes,
        })
      end,
    })
  end,
}