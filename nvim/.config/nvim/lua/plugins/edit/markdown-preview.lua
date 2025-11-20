vim.pack.add({
  { src = 'https://github.com/iamcco/markdown-preview.nvim' },
})

vim.fn['mkdp#util#install']()

vim.g.mkdp_filetypes = { 'markdown' }
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 1
vim.g.mkdp_refresh_slow = 0

vim.keymap.set('n', '<leader>mp', ':MarkdownPreviewToggle<cr>', { desc = 'Toggle markdown preview' })
