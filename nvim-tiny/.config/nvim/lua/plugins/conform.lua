vim.pack.add({
  { src = 'https://github.com/stevearc/conform.nvim' },
})

require('conform').setup({
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
    javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
    json = { 'prettierd', 'prettier', stop_after_first = true },
    sh = { 'shfmt' },
    zsh = { 'beautysh' },
  },
  formatters = {
    prettier = {
      prepend_args = { '--no-semi', '--single-quote', '--jsx-single-quote', '--print-width=120' },
    },
    stylua = {
      prepend_args = { '--quote-style', 'AutoPreferSingle', '--indent-type', 'Spaces', '--indent-width', '2' },
    },
    shfmt = {
      args = { '-i', '4', '-ci', '-bn', '-sr', '-s' },
    },
    beautysh = {
      prepend_args = { '-i', '2', '-s', 'fnpar' },
    },
  },
  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_format = 'fallback',
  -- },
})

vim.keymap.set('n', '<leader>f', function()
  require('conform').format({ timeout_ms = 500, lsp_format = 'fallback' })
end, { desc = 'Format the current buffer' })
