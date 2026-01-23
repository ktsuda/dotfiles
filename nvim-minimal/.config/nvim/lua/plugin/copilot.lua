vim.pack.add({
  { src = 'https://github.com/zbirenbaum/copilot.lua' },
})

require('copilot').setup({
  panel = { enabled = false },
  suggestion = {
    enabled = false,
    -- auto_trigger = true,
    -- keymap = {
    --   accept = '<C-y>',
    --   accept_word = false,
    --   accept_line = false,
    --   next = '<C-n>',
    --   prev = '<C-p>',
    --   dismiss = '<C-g>',
    --   toggle_auto_trigger = false,
    -- },
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
