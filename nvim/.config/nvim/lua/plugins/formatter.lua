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
          'typescript',
          'typescriptreact',
          'javascriptreact',
          'graphql',
          'html',
          'css',
          'scss',
          'yaml',
          'markdown',
          'less',
          'jsonc',
          'json',
          'javascript',
          'vue',
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
      formatting.trim_whitespace,
    }
    local group = vim.api.nvim_create_augroup('lsp_format_on_save', { clear = false })
    local event = 'BufWritePre'
    local async = event == 'BufWritePost'
    local on_attach = function(client, bufnr)
      if client.supports_method('textDocument/formatting') then
        vim.api.nvim_buf_set_option(bufnr, 'formatexpr', '')
        vim.keymap.set('n', '<space>f', function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = '[lsp] format' })

        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd(event, {
          buffer = bufnr,
          group = group,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr, async = async })
          end,
          desc = '[lsp] format on save',
        })
      end
      if client.supports_method('textDocument/rangeFormatting') then
        vim.keymap.set('x', '<Leader>f', function()
          vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
        end, { buffer = bufnr, desc = '[lsp] format' })
      end
    end
    return {
      sources = sources,
      on_attach = on_attach,
    }
  end,
}
