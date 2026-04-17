vim.pack.add({
  { src = 'https://github.com/dhruvasagar/vim-table-mode' },
  { src = 'https://github.com/iamcco/markdown-preview.nvim' },
  { src = "https://github.com/hedyhli/markdown-toc.nvim" },
}, {
  load = true,
})

vim.fn['mkdp#util#install']()
vim.cmd('silent TableModeEnable')
require('mtoc').setup()
