vim.pack.add({
  { src = 'https://github.com/zbirenbaum/copilot.lua' },
})

require('copilot').setup({
  panel = { enabled = false },
  suggestion = {
    enabled = false,
  },
  filetypes = {
    lua = true,
    c = true,
    cpp = true,
    javascript = true,
    typescript = true,
    javascriptreact = true,
    typescriptreact = true,
    sh = true,
    zsh = true,
    ['*'] = false,
  },
})
