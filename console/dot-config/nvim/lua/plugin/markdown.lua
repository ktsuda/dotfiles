vim.pack.add({
  { src = 'https://github.com/dhruvasagar/vim-table-mode' },
  { src = "https://github.com/hedyhli/markdown-toc.nvim" },
}, {
  load = true,
})

vim.cmd('silent TableModeEnable')
require('mtoc').setup()
