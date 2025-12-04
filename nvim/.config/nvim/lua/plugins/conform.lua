local function load()
  vim.pack.add({
    { src = 'https://github.com/stevearc/conform.nvim' },
    { src = 'https://github.com/zapling/mason-conform.nvim', version = 'main' },
  })

  require('conform').setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      -- cuda = { 'clang-format' },
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
      python = { 'isort', 'black' },
      markdown = { 'markdownlint' },
      -- go = { 'goimports' },
      -- ruby = { 'rubocop' },
      -- ['*'] = { 'trim_whitespace', 'trim_newlines' },
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
      ['clang-format'] = {
        prepend_args = { '-style=file' },
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

  require('mason-conform').setup({
    automatic_installation = true,
  })
end

local group = vim.api.nvim_create_augroup('my.conform', {})

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
