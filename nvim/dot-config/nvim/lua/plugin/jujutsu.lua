vim.pack.add({
  { src = 'https://github.com/yannvanhalewyn/jujutsu.nvim' },
  { src = 'https://github.com/sindrets/diffview.nvim' },
})

require('jujutsu-nvim').setup({
  diff_preset = 'diffview',
})
