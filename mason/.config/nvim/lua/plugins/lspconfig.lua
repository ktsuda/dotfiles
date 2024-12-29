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
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add a workspace folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove a workspace folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, 'List workspace folders')
      nmap('gD', vim.lsp.buf.declaration, 'Go to declaration')
      nmap('gd', vim.lsp.buf.definition, 'Go to definition')
      nmap('gi', vim.lsp.buf.implementation, 'Go to implementation')
      nmap('<leader>sh', vim.lsp.buf.signature_help, 'Show signature help')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Go to type definition')
      nmap('gr', vim.lsp.buf.references, 'Show references')
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })
    end

    local on_init = function(client, _)
      if client.supports_method('textDocument/semanticTokens') then
        client.server_capabilities.semanticTokensProvider = nil
      end
    end

    local server_configs = {
      clangd = {},
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
            diagnostics = { globals = { 'vim' } },
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
    -- local flags = { debounce_text_chages = 150 }
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    capabilities.textDocument.completion.completionItem = {
      documentationFormat = { 'markdown', 'plaintext' },
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

    local mason_lspc = require('mason-lspconfig')
    mason_lspc.setup({
      automatic_installation = true,
      ensure_installed = vim.tbl_keys(server_configs),
    })
    local lspconfig = require('lspconfig')
    mason_lspc.setup_handlers({
      function(server_name)
        local config = vim.tbl_deep_extend('force', server_configs[server_name] or {}, {
          capabilities = capabilities,
          on_attach = on_attach,
          -- flags = flags,
          on_init = on_init,
        })
        lspconfig[server_name].setup(config)
      end,
    })
  end,
}
