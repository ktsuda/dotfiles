return {
  'jose-elias-alvarez/null-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    {
      'williamboman/mason.nvim',
      cmd = 'Mason',
      opts = {},
    },
    {
      'jay-babu/mason-null-ls.nvim',
      opts = {
        ensure_installed = {
          'prettierd',
          'clang-format',
          'shfmt',
          'stylua',
          'black',
          'gofmt',
          'goimports',
          'rubocop',
          'erb-lint',
        },
        automatic_installation = false,
        automatic_setup = false,
      },
    },
  },
  opts = function()
    local null_ls = require('null-ls')
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    local sources = {
      formatting.prettierd.with({
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
          'json',
          'jsonc',
          'markdown',
          'graphql',
        },
        extra_args = {
          '--no-semi',
          '--single-quote',
          '--jsx-single-quote',
        },
      }),
      formatting.clang_format,
      formatting.shfmt.with({
        extra_args = {
          '-i',
          4,
          '-ci',
          '-bn',
          '-sr',
          '-s',
        },
      }),
      formatting.stylua.with({
        extra_args = {
          '--quote-style',
          'AutoPreferSingle',
          '--indent-type',
          'Spaces',
          '--indent-width',
          2,
        },
      }),
      formatting.black,
      formatting.gofmt,
      formatting.goimports,
      formatting.rubocop,
      diagnostics.rubocop,
      formatting.erb_lint,
      diagnostics.erb_lint,
    }
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
        end, { buffer = bufnr, desc = '[lsp] format' })

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
          desc = '[lsp] format on save',
        })
      end
      if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', '<Leader>f', function()
          vim.lsp.buf.format({
            formatting_options = formatting_options,
            bufnr = bufnr,
            async = true,
          })
        end, { buffer = bufnr, desc = '[lsp] format' })
      end
    end
    return {
      sources = sources,
      on_attach = on_attach,
    }
  end,
}
