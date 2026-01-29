vim.pack.add({
  { src = 'https://github.com/iamcco/markdown-preview.nvim' },
}, {
  load = true,
})

vim.fn['mkdp#util#install']()
