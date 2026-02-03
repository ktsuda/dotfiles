vim.pack.add({
  { src = 'https://github.com/folke/snacks.nvim' },
})

local s = require('snacks')
s.setup({
  notifier = {
    enabled = true,
  },
  picker = {
    hidden = true,
    ignore = true,
    sources = {
      files = {
        hidden = true,
        ignore = true,
      },
    },
  },
  explorer = {
    replace_netrw = true,
    diagnostics = true,
    git_status = true,
    git_untracked = true,
    follow_file = true,
  },
})
