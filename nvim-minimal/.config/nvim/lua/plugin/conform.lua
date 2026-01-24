vim.pack.add({
  { src = 'https://github.com/stevearc/conform.nvim' },
  { src = 'https://github.com/zapling/mason-conform.nvim', version = 'main' },
})

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    c = { 'clang-format' },
    cpp = { 'clang-format' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    css = { 'prettierd', 'prettier', stop_after_first = true },
    scss = { 'prettierd', 'prettier', stop_after_first = true },
    yaml = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    sh = { 'shfmt' },
    zsh = { 'beautysh' },
    markdown = { 'markdownlint' },
  },
  formatters = {
    stylua = {
      prepend_args = { '--quote-style', 'AutoPreferSingle', '--indent-type', 'Spaces', '--indent-width', '2' },
    },
    ['clang-format'] = {
      prepend_args = { '-style=file' },
    },
    prettierd = {
      prepend_args = { '--print-width=120' },
    },
    prettier = {
      prepend_args = { '--print-width=120' },
    },
    shfmt = {
      args = { '-i', '4', '-ci', '-bn', '-sr', '-s' },
    },
    beautysh = {
      prepend_args = { '-i', '2', '-s', 'fnpar' },
    },
  },
})

require('mason-conform').setup({
  automatic_installation = true,
  ignore_install = {
    'clang-format',
    'beautysh',
  },
})
