vim.pack.add({
  { src = 'https://github.com/tpope/vim-fugitive' },
  { src = 'https://github.com/tpope/vim-rhubarb' },
})

vim.keymap.set('n', '<leader>gs', '<cmd>0G<cr>', { desc = 'Git status' })
vim.keymap.set('n', '<leader>gd', '<cmd>Gdiff<cr>', { desc = 'Git diff' })
vim.keymap.set('n', '<leader>gr', '<cmd>GBrowse<cr>', { desc = 'Browse repo' })
