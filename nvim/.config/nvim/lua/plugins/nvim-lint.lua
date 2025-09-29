return {
  'mfussenegger/nvim-lint',
  enabled = true,
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },
      markdown = { 'markdownlint' },
      go = { 'golangcilint' },
      python = { 'pylint' },
      ruby = { 'rubocop' },
      sh = { 'shellcheck' },
      erb = { 'erb_lint' },
      lua = { 'selene' },
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    lint.linters.pylint.cmd = 'python3'
    lint.linters.pylint.args = { '-m', 'pylint', '-f', 'json' }
  end,
}
