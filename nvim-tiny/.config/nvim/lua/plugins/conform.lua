return {
  'stevearc/conform.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({
          lsp_fallback = true,
          async = false,
          timeout_ms = 500,
        })
      end,
      desc = 'Conform: Format buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { 'prettierd', 'prettier', stop_after_first = true },
      typescript = { 'prettierd', 'prettier', stop_after_first = true },
      javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
      html = { 'prettierd', 'prettier', stop_after_first = true },
      css = { 'prettierd', 'prettier', stop_after_first = true },
      scss = { 'prettierd', 'prettier', stop_after_first = true },
      yaml = { 'prettierd', 'prettier', stop_after_first = true },
      json = { 'prettierd', 'prettier', stop_after_first = true },
      markdown = { 'markdownlint' },
      lua = { 'stylua' },
      go = { 'goimports' },
      python = { 'isort', 'black' },
      ruby = { 'rubocop' },
      sh = { 'shfmt' },
      zsh = { 'beautysh' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      cuda = { 'clang_format' },
      ['*'] = { 'trim_whitespace', 'trim_newlines' },
    },
    formatters = {
      prettier = {
        prepend_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
      },
      stylua = {
        prepend_args = { '--quote-style', 'AutoPreferSingle', '--indent-type', 'Spaces', '--indent-width', 2 },
      },
      shfmt = {
        args = { '-i', 4, '-ci', '-bn', '-sr', '-s' },
      },
      beautysh = {
        prepend_args = { '-i', 2, '-s', 'fnpar' },
      },
      clang_format = {
        prepend_args = { '-style=file' },
      },
    },
  },
}
