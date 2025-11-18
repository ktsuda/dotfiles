local group = vim.api.nvim_create_augroup('my.lint', { clear = true })

local function load()
  vim.pack.add({
    { src = 'https://github.com/mfussenegger/nvim-lint' },
    { src = 'https://github.com/rshkarin/mason-nvim-lint' },
  })

  local lint_status, lint = pcall(require, 'lint')
  if not lint_status then
    return
  end

  lint.linters_by_ft = {
    javascript = { 'eslint_d' },
    typescript = { 'eslint_d' },
    javascriptreact = { 'eslint_d' },
    typescriptreact = { 'eslint_d' },
    markdown = { 'markdownlint' },
    sh = { 'shellcheck' },
  }

  vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
    group = group,
    callback = function()
      lint.try_lint()
    end,
  })

  lint.linters.pylint.cmd = 'python3'
  lint.linters.pylint.args = { '-m', 'pylint', '-f', 'json' }

  require('mason-nvim-lint').setup({
    automatic_installation = true,
  })
end

local cmd = {
  group = group,
  once = true,
  callback = load,
}

local events = { 'BufReadPre', 'BufNewFile' }

vim.api.nvim_create_autocmd(events, cmd)
