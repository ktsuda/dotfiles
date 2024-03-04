return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason.nvim',
      build = ':MasonUpdate',
      cmd = 'Mason',
      opts = {},
    },
    { 'jay-babu/mason-null-ls.nvim' },
  },
  config = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    require('mason-null-ls').setup({
      ensure_installed = {
        'prettierd',
        'stylua',
        'jq',
        'markdownlint',
        'clang_format',
        'shfmt',
        'black',
        'goimports',
        'rubocop',
        'erb_lint',
      },
      handlers = {
        function() end,
        prettierd = function(_)
          null_ls.register(formatting.prettierd.with({
            filetypes = {
              'javascript',
              'javascriptreact',
              'typescript',
              'typescriptreact',
              'vue',
              'html',
              'css',
              'scss',
              'less',
              'yaml',
              'graphql',
            },
            extra_args = {
              '--no-semi',
              '--single-quote',
              '--jsx-single-quote',
            },
          }))
        end,
        stylua = function(_)
          null_ls.register(formatting.stylua.with({
            extra_args = {
              '--quote-style',
              'AutoPreferSingle',
              '--indent-type',
              'Spaces',
              '--indent-width',
              2,
            },
          }))
        end,
        jq = function(_)
          null_ls.register(formatting.jq)
        end,
        markdownlint = function(_)
          null_ls.register(formatting.markdownlint)
          null_ls.register(diagnostics.markdownlint)
        end,
        clang_format = function(_)
          null_ls.register(formatting.clang_format.with({
            extra_args = {
              '-style=file',
            },
          }))
        end,
        shfmt = function(_)
          null_ls.register(formatting.shfmt.with({
            extra_args = {
              '-i',
              4,
              '-ci',
              '-bn',
              '-sr',
              '-s',
            },
          }))
        end,
        black = function(source_name, methods)
          require('mason-null-ls').default_setup(source_name, methods)
        end,
        goimports = function(source_name, methods)
          require('mason-null-ls').default_setup(source_name, methods)
        end,
        rubocop = function(source_name, methods)
          require('mason-null-ls').default_setup(source_name, methods)
        end,
        erb_lint = function(source_name, methods)
          require('mason-null-ls').default_setup(source_name, methods)
        end,
      },
    })

    local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
    local formatting_options = {
      trimTrailingWhitespace = true,
      insertFinalNewline = false,
      trimFinalNewlines = true,
    }
    local on_attach = function(client, bufnr)
      if client.server_capabilities.documentFormattingProvider then
        vim.api.nvim_buf_set_option(bufnr, 'formatexpr', '')
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format({
            formatting_options = formatting_options,
            filter = function(_client)
              return _client.name ~= 'jq'
            end,
            bufnr = bufnr,
            async = true,
          })
        end, { buffer = bufnr, desc = 'LSP: [f]ormat' })

        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.format({
              formatting_options = formatting_options,
              filter = function(_client)
                return _client.name ~= 'jq'
              end,
              bufnr = bufnr,
              timeout_ms = 2000,
              async = false,
            })
          end,
          desc = 'LSP: format on save',
        })
      end
      if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', '<Leader>f', function()
          vim.lsp.buf.format({
            formatting_options = formatting_options,
            bufnr = bufnr,
            async = true,
          })
        end, { buffer = bufnr, desc = 'LSP: [f]ormat' })
      end
    end
    null_ls.setup({
      on_attach = on_attach,
    })
  end,
}
