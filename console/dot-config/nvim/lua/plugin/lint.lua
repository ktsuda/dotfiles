vim.pack.add({
  { src = 'https://github.com/mfussenegger/nvim-lint' },
  { src = 'https://github.com/rshkarin/mason-nvim-lint' },
})

local lint = require('lint')

lint.linters_by_ft = {
  javascript = { 'eslint_d' },
  typescript = { 'eslint_d' },
  javascriptreact = { 'eslint_d' },
  typescriptreact = { 'eslint_d' },
  markdown = { 'markdownlint' },
}

lint.linters.pylint.cmd = 'python3'
lint.linters.pylint.args = { '-m', 'pylint', '-f', 'json' }
lint.linters.markdownlint.args = { '--disable', 'MD033', '--' }

require('mason-nvim-lint').setup({
  automatic_installation = true,
})
