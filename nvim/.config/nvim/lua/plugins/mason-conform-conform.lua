return {
  'stevearc/conform.nvim',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    formatters_by_ft = {
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      javascriptreact = { 'prettier' },
      typescriptreact = { 'prettier' },
      svelte = { 'prettier' },
      vue = { 'prettier' },
      html = { 'prettier' },
      css = { 'prettier' },
      scss = { 'prettier' },
      less = { 'prettier' },
      yaml = { 'prettier' },
      json = { 'prettier' },
      markdown = { 'markdownlint' },
      graphql = { 'prettier' },
      lua = { 'stylua' },
      go = { 'goimports' },
      python = { 'isort', 'black' },
      ruby = { 'rubocop' },
      sh = { 'shfmt' },
      zsh = { 'beautysh' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      objc = { 'clang_format' },
      objcpp = { 'clang_format' },
      cuda = { 'clang_format' },
      proto = { 'clang_format' },
      erb = { 'erb_format' },
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
    -- format_on_save = {
    --   lsp_fallback = true,
    --   async = false,
    --   timeout_ms = 500,
    -- },
  },
  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)
    vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 500,
      })
    end, { desc = 'Conform: Format buffer' })
  end,
}
